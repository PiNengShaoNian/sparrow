import test_utils for assert_equal

var bob = 5.5
assert_equal("5.5", "%(bob)", "`5.5` assert failed!")
assert_equal("val: 8 and 8", "val: %(5.5 + 2.5) and %(bob + 2.5)", "`val: 8 and 8` assert failed!")