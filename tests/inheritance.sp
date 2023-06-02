import test_utils for assert_equal

class Animal {
  var name

  new(_name) {
    name = _name
  }

  sayHello() {
    return name
  }
}

class Dog < Animal {
  var age
  new(name, _age) {
    super(name)
    age = _age
  }

  remainingLife {
    return 20 - age
  }
}

var dog = Dog.new("旺财", 3)

assert_equal(dog.age, 3, "assert failed!")
assert_equal(dog.name, "旺财", "assert failed!")
assert_equal(dog.sayHello(), dog.name, "assert failed!")
assert_equal(dog.remainingLife, 17, "assert failed!")


class Husky < Dog {
  var color
  new(name, age, _color) {
    super(name, age)
    color = _color
  }

  sayHello() {
    return "Husky " + name
  }
}

var husky = Husky.new("husky1", 8, "white")
assert_equal(husky.age, 8, "assert failed!")
assert_equal(husky.name, "husky1", "assert failed!")
assert_equal(husky.sayHello(), "Husky husky1", "assert failed!")
assert_equal(husky.remainingLife, 12, "assert failed!")