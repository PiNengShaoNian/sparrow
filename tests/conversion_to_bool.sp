import test_utils for assert_equal

assert_equal(!false, true, "`!false == true` assert failed!")
assert_equal(!true, false, "`!true == false` assert failed!")
assert_equal(!0, false, "`!0 == false` assert failed!")
assert_equal(!({}), false, "`!({}) == false` assert failed!")
assert_equal(!([]), false, "`!([]) == false` assert failed!")