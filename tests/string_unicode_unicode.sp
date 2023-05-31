import test_utils for assert_equal

assert_equal("\uc39c", "쎜", "assert failed!")
assert_equal("U for \u00dcmlauts", "U for Ümlauts", "assert failed!")

assert_equal("Thorn \u00fe sign", "Thorn þ sign", "assert failed!")
assert_equal("Test\u0020Me", "Test Me", "assert failed!")
assert_equal("Test\u2022Me", "Test•Me", "assert failed!")

assert_equal("\U0001F34C", "🍌", "assert failed!")

assert_equal("\U00024B62", "𤭢", "assert failed!")

assert_equal("Test\U0001F534Me", "Test🔴Me", "assert failed!")