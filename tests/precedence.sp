import test_utils for assert_equal

assert_equal(14, 2 + 3 * 4, "assert failed!")
assert_equal(-2, 5 - 4 - 3, "assert failed!")
assert_equal(0, 10 / 5 % 2, "assert failed!")
var i = 5
assert_equal(4, i -= 5 - 4, "assert failed!")
//assert_equal(++i * i, 9)