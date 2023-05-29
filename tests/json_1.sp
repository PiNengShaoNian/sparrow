import test_utils for assert_equal
import json for from_json

assert_equal(from_json("null"), null, "`from_json(\"null\") == null` assert failed!")