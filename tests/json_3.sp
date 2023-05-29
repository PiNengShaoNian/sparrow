import test_utils for assert_equal
import json for from_json

assert_equal(from_json("100"), 100, "`from_json(\"100\") == 100` assert failed!")
