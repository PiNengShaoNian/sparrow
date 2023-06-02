import test_utils for assert_deep_equal

var TargetEffect = null

class ReactiveEffect {
  var deps
  var fn
  new(_fn) {
    deps = []
    fn = _fn
  }

  run() {
    fn.call()
  }

  stop() {
    for dep (deps) {
      dep.remove(this)
    }
  }
}

class RefImpl {
  var value
  var effects
  new(v) {
    value = v
    effects = {}
  }

  value=(newVal) {
    value = newVal
    for effect (effects.keys) {
      effect.run()
    }
    return newVal
  }

  value {
    if(TargetEffect != null) {
      effects[TargetEffect] = true
      TargetEffect.deps.add(effects)
    }
    return value
  }
}

fun watch(getter, fn) {
  var effect = ReactiveEffect.new(fn)
  TargetEffect = effect
  getter()
  TargetEffect = null

  return Fn.new{
    effect.stop()
  }
}

fun ref(val) {
  return RefImpl.new(val)
}

var actual = []
var count = ref(0)
var stop1 = watch(Fn.new{
  count.value
}, Fn.new{
  actual.add("1: %(count.value)")
})

watch(Fn.new{
  count.value
},Fn.new{
  actual.add("2: %(count.value * 2)")
})

count.value++
count.value++

stop1()

count.value++
count.value++

assert_deep_equal(["1: 1", "2: 2", "1: 2", "2: 4", "2: 6", "2: 8"], actual, "assert failed!")