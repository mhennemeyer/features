        class SayHelloWorldTest < RailsTestCaseClass
        def test_WithABlankObject
      Given_a_blank_Object; When_i_send_it_hello; It_should_return___("Hello, World!")
    end
     def test_WithACustomObject
      Given_a_custom_Object_with_name___("Bob"); When_i_send_it_hello; It_should_return___("Hello, World! I am Bob.")
    end

    end
     class SayHelloUniverseTest < RailsTestCaseClass
        def test_WithABlankObject
      Given_a_blank_Object; When_i_send_it_helloUniverse; It_should_return___("Hello, Universe!")
    end
     def test_WithACustomObject
      Given_a_custom_Object_with_name___("Bob"); When_i_send_it_helloUniverse; It_should_return___("Hello, Universe! I am Bob.")
    end

    end
     class SayHelloTest < RailsTestCaseClass
        def test_WithABlankObject
      Given_a_blank_Object; When_i_send_it_hello; It_should_return___("Hello, World!")
    end
     def test_WithACustomObject
      Given_a_blank_Object; When_i_send_it_hello; It_should_return___("Hello, World!"); Given_a_custom_Object_with_name___("Bob"); When_i_send_it_hello; It_should_return___("Hello, World! I am Bob.")
    end

    end

