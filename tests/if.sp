import test_utils for assert_equal

var t = false

if (true) {
  t = true
}

assert_equal(true, t, "`true == t` assert failed!")