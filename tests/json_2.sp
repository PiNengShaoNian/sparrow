import test_utils for assert_equal
import json for from_json

assert_equal(from_json("true"), true, "`from_json(\"true\") == true` assert failed!")
