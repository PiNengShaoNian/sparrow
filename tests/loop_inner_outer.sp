import test_utils for assert_equal

var total = 0

for i (0..9) {
  for j (0..9) {
    total = total + 1
  }
}

assert_equal(100, total, "assert failed!")