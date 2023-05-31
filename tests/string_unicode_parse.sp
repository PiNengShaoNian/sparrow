import test_utils for assert_equal

assert_equal("\u00aa", "\u00AA", "assert failed!")

assert_equal("Test\u0040", "Test@", "assert failed!")