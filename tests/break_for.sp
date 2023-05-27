import test_utils for assert_equal

var j = 0

for i (0..9) {
  if (i == 5) {
    break
  }

  j = i
}

assert_equal(4, j, "4 == j assert failed!")