require "/Users/mhennemeyer/Projekte/features/spec/Rails/Resources/features_helper.rb"

class SayHelloWorldTest < FeaturesTestCaseClass
  def test_WithABlankObject
  given_a_blank_Object; when_i_send_it_hello; it_should_return___("Hello, World!")
end

def test_WithACustomObject
  given_a_custom_Object_with_name___("Bob"); when_i_send_it_hello; it_should_return___("Hello, World! I am Bob.")
end

def test_WithAFollowUp
  given_a_custom_Object_with_name___("Bob"); when_i_send_it_hello; it_should_return___("Hello, World! I am Bob."); it_should_return___("Hello, World! I am Bob.")
end

end

class SayHelloUniverseTest < FeaturesTestCaseClass
  def test_WithABlankObject
  given_a_blank_Object; when_i_send_it_helloUniverse; it_should_return___("Hello, Universe!")
end

def test_WithACustomObject
  given_a_custom_Object_with_name___("Bob"); when_i_send_it_helloUniverse; it_should_return___("Hello, Universe! I am Bob.")
end

end

class SayHelloTest < FeaturesTestCaseClass
  def test_WithABlankObject
  given_a_blank_Object; when_i_send_it_hello; it_should_return___("Hello, World!")
end

def test_WithACustomObject
  given_a_blank_Object; when_i_send_it_hello; it_should_return___("Hello, World!"); given_a_custom_Object_with_name___("Bob"); when_i_send_it_hello; it_should_return___("Hello, World! I am Bob.")
end

end

