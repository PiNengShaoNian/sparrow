import test_utils for assert_true

var v = [[[15]]]

assert_true(v[0][0][0] == 15, "`v[0][0][0] == 15` assert failed")