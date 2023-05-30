import test_utils for assert_equal

class MyClass {
    var value
    new(v) { this.value = v }
    getWrappedIncrement() { return MyClass.new(this.value + 1) }
    getValue { return this.value }
}

fun foo(x) {
    return MyClass.new(x+1)
}

var x = [1, 2,
 3, 4]

assert_equal(1, x[0], "assert failed!")

fun map(list, fn) {
  var ans = []
  for x (list) {
    ans.add(fn(x))
  }

  return ans
}

var y = map(x, 
 Fn.new{|x| return x + 1 })

assert_equal(2, y[0], "assert failed!")

var z = foo(1)
.value

assert_equal(2, z, "assert failed!")

var v = foo(2)
.getValue

assert_equal(3, v, "assert failed!")

var u = MyClass.new(3)
.getWrappedIncrement()

.getWrappedIncrement()
.getValue

assert_equal(5, u, "assert failed!")