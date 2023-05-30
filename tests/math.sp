import test_utils for assert_equal

assert_equal(3, (1 + 2), "assert failed!")
assert_equal(3.5, 1.5 + 2, "assert failed!")
assert_equal(2, 10/5, "assert failed!")
assert_equal(2, 11 % 3, "assert failed!")
assert_equal(12, 3 * 4, "assert failed!")
assert_equal(-7, -(3 + 4), "assert failed!")
assert_equal(27, 3*(4+5), "assert failed!")
assert_equal(2, 5 - 3, "assert failed!")