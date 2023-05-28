import test_utils for assert_equal

assert_equal(true, 1 < 2, "`true == (1 < 2)` assert failed!")
assert_equal(false, 2 < 2, "`false == (2 < 2)` assert failed!")
assert_equal(false, 2 < 1, "`false == (2 < 1)` assert failed!")
assert_equal(false, 2.5 < 1, "`false == (2.5 < 1)` assert failed!")
assert_equal(true, 1 < 1.5, "`true == (1 < 1.5)` assert failed!")