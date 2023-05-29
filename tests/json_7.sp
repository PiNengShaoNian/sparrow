import test_utils for assert_equal
import json for from_json

var list = from_json("[]")

assert_equal(list.type, List, "`list.type == List` assert failed")
assert_equal(list.count, 0, "`list.count == 0` assert failed")