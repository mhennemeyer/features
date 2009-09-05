require File.dirname(__FILE__) + '/spec_helper'

describe "Integrational en" do
  before(:each) do
    @feature_files_path = File.dirname(__FILE__) + "/Resources"
    @suite = RailsSuite.new({
      :feature_files_path         => @feature_files_path,
      :feature_file_suffix        => "feature",
      :test_cases_file            => @feature_files_path + "/FeatureTestCases.rb",
      :project_name               => "Rails Features",
      :features_helper            => @feature_files_path + "/features_helper.rb"
    })
    @suite.run
  end
      
  it "exposes itself as a string" do
    expected = <<-END
  require "#{@feature_files_path + "/features_helper.rb"}"
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
  END
    @suite.to_s.ignore_whitespace.should eql(expected.ignore_whitespace)
  end
end

describe "Integrational de" do
  before(:each) do
    @feature_files_path = File.dirname(__FILE__) + "/Resources/de"
    @suite = RailsSuite.new({
      :feature_files_path         => @feature_files_path,
      :feature_file_suffix        => "funktion",
      :test_cases_file            => @feature_files_path + "/FeatureTestCases.rb",
      :project_name               => "De Features",
      :features_helper            => @feature_files_path + "/features_helper.rb",
      :feature_keyword            => "Funktion:",
      :scenario_keyword           => "Beispiel:",
      :given_scenario_keyword     => "Gegeben:",
      :follow_up_keyword          => "Und"
    })
    @suite.run
  end
      
  it "exposes itself as a string" do
    expected = <<-END
  require "#{@feature_files_path + "/features_helper.rb"}"
  class AnmeldenTest < FeaturesTestCaseClass 
    def test_NeuerBenutzerWirdAngemelded 
      wenn_ich_die_Seite____oeffne("/"); 
      dann_sehe_ich___("Anmelden"); 
      wenn_ich_auf____klicke("Anmelden"); 
      dann_sehe_ich___("Email:"); 
      dann_sehe_ich___("Passwort:") 
    end 
  end
  END
    @suite.to_s.ignore_whitespace.should eql(expected.ignore_whitespace)
  end
end