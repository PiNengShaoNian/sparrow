import test_utils for assert_equal

assert_equal("\u0020", " ", "assert failed!")
assert_equal("\u0021", "!", "assert failed!")
assert_equal("\u0030", "0", "assert failed!")
assert_equal("\u0040", "@", "assert failed!")
assert_equal("\u005B", "[", "assert failed!")
assert_equal("\u005d", "]", "assert failed!")
assert_equal("\u0061", "a", "assert failed!")
assert_equal("\u007e", "~", "assert failed!")