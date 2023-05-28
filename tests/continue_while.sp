import test_utils for assert_equal

var i = 0
var j = 0

while (i < 10) {
  i = i + 1
  if (i > 5)
  {
    continue
  }

  j = i
}

assert_equal(10, i, "`10 == i` assert failed!")
assert_equal(5, j, "`5 == j` assert failed!")