    require "/Users/mhennemeyer/Projekte/features/spec/Rails/Resources/railsapp/test/features/support/features_helper.rb"
        class HelloWorldTest < FeaturesTestCaseClass
        def test_HelloWorld
      given_Hello_World
    end

    end
     class OpenTheAppTest < FeaturesTestCaseClass
        def test_OpenTheApp
      when_i_go_to___("/"); then_i_should_see___("Hello, World!")
    end

    end

