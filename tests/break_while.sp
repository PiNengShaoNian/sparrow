import test_utils for assert_equal

var i = 0
while (i < 10) {
  i = i + 1
  if (i == 5) {
    break
  }
}

assert_equal(5, i, "`5 == i` assert failed!")