import test_utils for assert_equal

fun bob1(x, y, z) {
  return x + y + z
}

fun bob2(x, y) {
  return x - y
}

fun bob3(x) {
  return -x
}

fun bob4() {
  return 10
}

assert_equal(10, bob4(), "assert failed!")
assert_equal(-5, bob3(5), "assert failed!")
assert_equal(-1, bob2(5,6), "assert failed!")
assert_equal(18, bob1(5,6,7), "assert failed!")