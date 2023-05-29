import test_utils for assert_equal
import json for from_json

var json = "\n" + 
"{\n" +
"    \"Key\" : \"Value\"\n" +
"}\n"
var expected = {
  "Key": "Value"
}
var actual = from_json(json)

assert_equal(expected.count, actual.count, "`expected.count == actual.count` assert failed!")

for key (expected.keys) {
  assert_equal(expected[key], actual[key], "`%(expected[key]) == %(actual[key])` assert failed!")
}