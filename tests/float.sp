import test_utils for assert_equal

assert_equal(true, 1.2 < 2, "`true == (1.2 < 2)` assert failed!")
assert_equal(true, 1.2 > 1, "`true == (1.2 > 1)` assert failed!")
assert_equal(1.2, 1.2, "`1.2 == 1.2` assert failed!")

assert_equal(true, .5 > 0, "`true == (.5 > 0)` assert failed!")
assert_equal(true, .5 < 1, "`true == (.5 < 1)` assert failed!")
assert_equal(0.5, .5, "`0.5 == .5` assert failed!")
