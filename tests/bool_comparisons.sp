import test_utils for assert_true, assert_false

assert_true(true == true, "`true == true` assert failed!")
assert_false(true == false, "`true == false` assert failed!")
assert_true(true != false, "`true != false` assert failed!")
assert_true(false != true, "`false != true` assert failed!")
assert_true(false || true, "`false || true` assert failed!")
assert_true(true || false, "`true || false` assert failed!")
assert_false(true && false, "`true && false` assert failed!")
assert_false(false && true, "`false && true` assert failed!")
assert_true(!false, "`!false` assert failed!")
assert_false(!true, "`!true` assert failed!")