import test_utils for assert_equal

var j = 0
var k = 0

for i (0..9)
{
  j = i
  if (i > 5)
  {
    continue
  } 

  k = i
}

assert_equal(5, k, "`5 == k` assert failed!")
assert_equal(9, j, "`9 == j` assert failed!")