import test_utils for assert_equal

var total = 0

switch(2) { 
  case 1: { 
    total += 1
    break
  } 
  case 2: { 
    total += 2 
    break
  } 
  case 3: { 
    total += 4
    break
  } 
  case 4: {
    total += 8
    break
  } 
}

assert_equal(total, 2, "assert failed!")