import test_utils for assert_equal
import json for from_json

var emptyMap = from_json("{}")
assert_equal(emptyMap.type, Map, "`emptyMap.type == Map`assert failed!")
assert_equal(emptyMap.count, 0, "`emptyMap.count == 0` assert failed!")