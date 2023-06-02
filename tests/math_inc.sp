import test_utils for assert_equal

var i = 3
assert_equal(3, i++, "assert failed!")
assert_equal(4, i, "assert failed!")

class Test {
  var x
  new() {
    x = 3
  }
}

var a = Test.new()
assert_equal(3, a.x++, "assert failed!")
assert_equal(4, a.x, "assert failed!")