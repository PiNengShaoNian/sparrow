import test_utils for assert_equal

assert_equal(false, 1 > 2, "`false == (1 > 2)` assert failed!")
assert_equal(false, 2 > 2, "`false == (2 > 2)` assert failed!")
assert_equal(true, 2 > 1, "`true == (2 > 1)` assert failed!")
assert_equal(true, 2.5 > 1, "`true == (2.5 > 1)` assert failed!")
assert_equal(false, 1 > 1.5, "`false == (1 > 1.5)` assert failed!")