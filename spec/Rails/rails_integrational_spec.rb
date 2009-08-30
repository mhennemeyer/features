require File.dirname(__FILE__) + '/spec_helper'

describe "Integrational" do
  before(:each) do
    @feature_files_path = File.dirname(__FILE__) + "/Resources"
    @suite = RailsSuite.new({
      :feature_files_path         => @feature_files_path,
      :feature_file_suffix        => "feature",
      :test_cases_file            => @feature_files_path + "/FeatureTestCases.rb",
      :project_name               => "Rails Features"
    })
    @suite.run
  end
      
  it "exposes itself as a string" do
    expected = <<-END
  class SayHelloWorldTest < FeaturesTestCaseClass
    def test_WithABlankObject
      Given_a_blank_Object; When_i_send_it_hello; It_should_return___("Hello, World!")
    end
    def test_WithACustomObject
      Given_a_custom_Object_with_name___("Bob"); When_i_send_it_hello; It_should_return___("Hello, World! I am Bob.")
    end
  end
  class SayHelloUniverseTest < FeaturesTestCaseClass
    def test_WithABlankObject
      Given_a_blank_Object; When_i_send_it_helloUniverse; It_should_return___("Hello, Universe!")
    end
    def test_WithACustomObject
      Given_a_custom_Object_with_name___("Bob"); When_i_send_it_helloUniverse; It_should_return___("Hello, Universe! I am Bob.")
    end
  end
  class SayHelloTest < FeaturesTestCaseClass
    def test_WithABlankObject
      Given_a_blank_Object; When_i_send_it_hello; It_should_return___("Hello, World!")
    end
    def test_WithACustomObject
      Given_a_blank_Object; When_i_send_it_hello; It_should_return___("Hello, World!"); Given_a_custom_Object_with_name___("Bob"); When_i_send_it_hello; It_should_return___("Hello, World! I am Bob.")
    end
  end
  END
    @suite.to_s.ignore_whitespace.should eql(expected.ignore_whitespace)
  end
end