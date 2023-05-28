import test_utils for assert_equal

assert_equal("\% (4 + 5)", "% (4 + 5)", "`\% (4 + 5)` assert failed!")
assert_equal("\%9", "%%(4+5)", "`\%9` assert failed!")
assert_equal("Value: \%(4 + 5)", "Value: \%(4 + 5)", "`Value: \%(4 + 5)` assert failed!")
assert_equal("Value: \%9", "Value: \%%(4 + 5)", "`Value: \%9` assert failed!")
assert_equal("\%code\%", "%code%", "`\%code\%` assert failed!")
assert_equal("\%\%", "%%", "`\%\%` assert failed!")
assert_equal("\%", "%", "`\%` assert failed!")
assert_equal("\%(", "\%(", "`\%(` assert failed!") // ensure this doesn't fail