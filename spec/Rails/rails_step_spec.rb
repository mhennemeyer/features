require File.dirname(__FILE__) + '/spec_helper'

describe RailsStep do
  describe "'Given a blank Object', with no args" do
    before(:each) do
      @line = "Given a blank Object"
      @step = RailsStep.new({
        :body  => @line
      }).aggregate!
    end
    
    it "knows if it has args" do
      @step.has_args?.should be_false
    end
    
    it "knows itself to render as html" do
      @step.to_html.should == '<h3 class="step">Given a blank Object</h3>'
    end
    
    it "finds the first part" do
      @step.first_part.should eql("given_a_blank_Object")
    end
    
    it "finds the args" do
      @step.args.should eql([])
    end
    
    it "preserves single quotes" do
      s = RailsStep.new({:title => "Given 'Blah'", :body => "Given 'Blah'"}).aggregate!
      s.to_html.should =~ /'/
    end

    it "has a body" do
      @step.body.should eql(@line)
    end

    it "has a message" do
      @step.message.should eql("given_a_blank_Object")
    end
    
    it "exposes itself as a string" do
      @step.to_s.should eql("given_a_blank_Object")
    end
    
    it "has a parameter_string" do
      @step.parameter_string.should eql("")
    end
    
  end
  
  describe "'Given a custom Object 'Bob'', with one arg 'Bob'" do
    before(:each) do
      @line = "Given a custom Object 'Bob'"
      @step = RailsStep.new({
        :body  => @line
      }).aggregate!
    end
    
    it "knows if it has args" do
      @step.has_args?.should be_true
    end
    
    it "finds the first part" do
      @step.first_part.should eql("given_a_custom_Object___")
    end
    
    it "finds the args" do
      @step.args.should eql(["Bob"])
    end

    it "has message: given_a_custom_Object___(\"Bob\")" do
      @step.message.should eql('given_a_custom_Object___("Bob")')
    end
    
    it "exposes itself as a string" do
      @step.to_s.should eql('given_a_custom_Object___("Bob")')
    end
    
    it "has a parameter_string" do
      @step.parameter_string.should eql("(arg)")
    end
  end
  
  describe "'Given a custom Object 'Bob' so far', with one arg 'Bob'" do
    before(:each) do
      @line = "Given a custom Object 'Bob' so far"
      @step = RailsStep.new({ 
        :body  => @line
      }).aggregate!
    end
    
    it "knows if it has args" do
      @step.has_args?.should be_true
    end
    
    it "finds the first part" do
      @step.first_part.should eql("given_a_custom_Object____so_far")
    end
    
    it "finds the args" do
      @step.args.should eql(["Bob"])
    end

    it "has message: given_a_custom_Object____so_far(\"Bob\")" do
      @step.message.should eql('given_a_custom_Object____so_far("Bob")')
    end
    
    it "exposes itself as a string" do
      @step.to_s.should eql('given_a_custom_Object____so_far("Bob")')
    end
  end
  
  describe "'Given a custom Object 'Bob' with attribute 'Jim'', with two args" do
    before(:each) do
      @line = "Given a custom Object 'Bob' with attribute 'Jim'"
      @step = RailsStep.new({ 
        :body  => @line
      }).aggregate!
    end
    
    it "knows if it has args" do
      @step.has_args?.should be_true
    end
    
    it "finds the args" do
      @step.args.should eql(["Bob", "Jim"])
    end
    
    it "finds the first part" do
      @step.first_part.should eql("given_a_custom_Object____with_attribute___")
    end

    it "has a message 'given_a_custom_Object____with_attribute___(\"Bob\", \"Jim\")'" do
      @step.message.should eql('given_a_custom_Object____with_attribute___("Bob", "Jim")')
    end
    
    it "exposes itself as a string" do
      @step.to_s.should eql('given_a_custom_Object____with_attribute___("Bob", "Jim")')
    end
    
    it "has a parameter_string" do
      @step.parameter_string.should eql("(arg, arg2)")
    end
  end
  
  describe "'Given a custom Object 'Bob' with attribute 'Jim' so far', with two args" do
    before(:each) do
      @line = "Given a custom Object 'Bob' with attribute 'Jim' so far"
      @step = RailsStep.new({
        :body  => @line
      }).aggregate!
    end

    it "has a message 'given_a_custom_Object____with_attribute____so_far(\"Bob\", \"Jim\")'" do
      @step.message.should eql('given_a_custom_Object____with_attribute____so_far("Bob", "Jim")')
    end
  end
  
  describe "'Given a custom Object 'Bob' with attribute 'Jim' and 'John'', with three args" do
    before(:each) do
      @line = "Given a custom Object 'Bob' with attribute 'Jim' and 'John'"
      @step = RailsStep.new({
        :body  => @line
      }).aggregate!
    end
    
    it "knows if it has args" do
      @step.has_args?.should be_true
    end
    
    it "finds the args" do
      @step.args.should eql(["Bob", "Jim", 'John'])
    end
    
    it "finds the first part" do
      @step.first_part.should eql("given_a_custom_Object____with_attribute____and___")
    end

    it "has a message 'given_a_custom_Object____with_attribute___:(\"Bob\", \"Jim\", \"John\")'" do
      @step.message.should eql('given_a_custom_Object____with_attribute____and___("Bob", "Jim", "John")')
    end
    
    it "has a parameter_string" do
      @step.parameter_string.should eql("(arg, arg2, arg3)")
    end
    
  end
end