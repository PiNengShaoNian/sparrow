import test_utils for assert_equal, assert_deep_equal

fun odd(n) {
  return n % 2 != 0
}

fun map(list, fn) {
  var ans = []
  for x (list) {
    ans.add(fn(x))
  }

  return ans
}

// Map function

{ 
  assert_deep_equal([true, false, true], map([1,2,3], odd), "assert failed!")

  var v = [1, 2, 3]
  var y = map(v, Fn.new{|s| return s * 2 })
  y[0] = 1
  assert_equal(1, y[0], "assert failed!")
} 


// Map objects

{
  var m = {"a":1, "b":2}

  assert_equal(true, m.containsKey("a"), "assert failed!")
  assert_equal(false, m.containsKey("c"), "assert failed!")
  assert_equal(1, m.remove("a"), "assert failed!")
  assert_equal(1, m.count, "assert failed!")
  assert_equal(null, m.remove("a"), "assert failed!")

  assert_equal(1, m.count, "assert failed!")

  m["c"] = 3
  m["b"] = 4

  assert_equal(3, m["c"], "assert failed!")
  assert_equal(4, m["b"], "assert failed!")
  assert_equal(2, m.count, "assert failed!")

  var v = "bob"

  m["d"] = v

  assert_equal("bob", m["d"], "assert failed!")
  v = "bob2"
  assert_equal("bob", m["d"], "assert failed!")

  var obj = {"a": 666}
  m["e"] = obj

  assert_equal(666, m["e"]["a"], "assert failed!")
  m["e"]["a"] = 777
  assert_equal(777, obj["a"], "assert failed!")
}