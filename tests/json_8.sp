import test_utils for assert_equal
import json for from_json

var list = from_json("[1,2,3]")
assert_equal(list.type, List, "`list.type == List` assert failed!")
assert_equal(list.count, 3, "`list.count == 3` assert failed!")
assert_equal(list[0], 1, "`list[0] == 1` assert failed!")
assert_equal(list[1], 2, "`list[1] == 2` assert failed!")
assert_equal(list[2], 3, "`list[2] == 3` assert failed!")