import test_utils for assert_equal

assert_equal("\u0039", "9", "`\"\u0039\" == \"9\"` assert failed!")
assert_equal("\u0039ec", "9ec", "`\"\u0039ec\" == \"9ec\"` assert failed!")
assert_equal("\u0039g", "9g", "`\"\u0039g\" == \"9g\"` assert failed!")
assert_equal("b\u0039g", "b9g", "`\"b\u0039g\" == \"b9g\"` assert failed!")
assert_equal("\u0039\u0038g", "98g", "`\"\u0039\u0038g\" == \"98g\"` assert failed!")