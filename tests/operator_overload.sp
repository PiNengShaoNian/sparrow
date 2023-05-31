import test_utils for assert_equal

class Bob {
  var x
  new() {}

  +(that) {
    return x + that.x
  }

  -(that) {
    return x - that.x
  }

  *(that) {
    return x * that.x
  }

  /(that) {
    return x / that.x
  }
}

var b = Bob.new()
var c = Bob.new()

b.x = 4
c.x = 5

assert_equal(9, b+c, "assert failed!")
assert_equal(-1, b-c, "assert failed!")
assert_equal(20, b*c, "assert failed!")
assert_equal(0.8, b/c, "assert failed!")