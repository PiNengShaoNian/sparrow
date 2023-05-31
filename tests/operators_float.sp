import test_utils for assert_equal

var i = 1.0
var j = 2.0
var k = 3.0

assert_equal(3, i + j, "assert failed!")
assert_equal(1.0, +i, "assert failed!")
assert_equal(-1, i-j, "assert failed!")
assert_equal(-1, -i, "assert failed!")
assert_equal(1.5, k/j, "assert failed!")
assert_equal(6, j*k, "assert failed!")