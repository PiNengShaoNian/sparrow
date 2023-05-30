import test_utils for assert_true

fun shouldnt_execute()
{
  assert_true(false, "assert failed!")
}



if (false && shouldnt_execute()) {
}

if (true || shouldnt_execute()) {
}


if (false || false || false || true || shouldnt_execute()) {
}


if (true && true && true && false && shouldnt_execute()) {
}