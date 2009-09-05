require File.dirname(__FILE__) + '/spec_helper'

describe "Follow Up" do
  before(:each) do
    
    @body = <<-END 
    Given a blank Object
    When i send it hello
    It should return 'Hello'
    And |Something|
    And |Something else|
    It should return 'Hello' and 'World' and '!'
    And |Something else|Blah|Blah|
    'This' starts with a placeholder
    And |That|
    Then i see 'Email:'
  	And |Passwort:|
    END
    
    @scenario = RailsScenario.new({
      :title => "A Scenario with a follow up step", 
      :body  => @body
    })
  end
  
  it "knows that it has follow ups" do
    @scenario.has_follow_ups?.should be_true
  end
  
  context "aggregated" do
    
    before(:each) do
      @mock_feature = mock(RailsFeature)
      @mock_feature.stub!(:scenarios).and_return([@scenario, @given_scenario])
      @scenario.stub!(:parent).and_return(@mock_feature)
      @scenario.collect_steps
    end
    
    it "expands follow ups in body" do
      expected = <<-END 
  Given a blank Object
  When i send it hello
  It should return 'Hello'
  It should return 'Something'
  It should return 'Something else'
  It should return 'Hello' and 'World' and '!'
  It should return 'Something else' and 'Blah' and 'Blah'
  'This' starts with a placeholder
  'That' starts with a placeholder
  Then i see 'Email:'
  Then i see 'Passwort:'
  END
      
      @scenario.expand_follow_ups_in_body.ignore_whitespace.should eql(expected.ignore_whitespace.strip)
    end
  end

end

describe "Follow Up, de" do
  before(:each) do
    
    @body = <<-END 
    Wenn ich die Seite '/' oeffne
  	Dann sehe ich 'Anmelden'
  	Wenn ich auf 'Anmelden' klicke
  	Dann sehe ich 'Email:'
  	Und |Passwort:|
    END
    
    @scenario = RailsScenario.new({
      :title => "Mit follow up", 
      :body  => @body,
      :follow_up_keyword => "Und"
    })
  end
  
  it "knows that it has follow ups" do
    @scenario.has_follow_ups?.should be_true
  end
  
  context "aggregated" do
    
    before(:each) do
      @mock_feature = mock(RailsFeature)
      @mock_feature.stub!(:scenarios).and_return([@scenario, @given_scenario])
      @scenario.stub!(:parent).and_return(@mock_feature)
      @scenario.collect_steps
    end
    
    it "expands follow ups in body" do
      expected = <<-END 
      Wenn ich die Seite '/' oeffne
    	Dann sehe ich 'Anmelden'
    	Wenn ich auf 'Anmelden' klicke
    	Dann sehe ich 'Email:'
    	Dann sehe ich 'Passwort:'
  END
      
      @scenario.expand_follow_ups_in_body.ignore_whitespace.should eql(expected.ignore_whitespace.strip)
    end
  end

end