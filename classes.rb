class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def say_hello
    puts "Hello, my name is #{@name} and I am #{@age} years old."
  end
end

person = Person.new("John", 30)
person.say_hello
