import test_utils for assert_deep_equal
import json for from_json, to_json

var m = {"a" : 1, "b" : [ 1, 2, 3 ], "c" : [1, "a string", {"d" : 15}]}

assert_deep_equal(from_json(to_json(m)), m, "json roundtrip assert failed!")