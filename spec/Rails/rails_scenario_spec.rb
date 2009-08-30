require File.dirname(__FILE__) + '/spec_helper'

describe RailsScenario do
  before(:each) do
    @scenario_body = <<-END 
  		Given a blank Object
  		When i send it hello
  		It should return 'Hello, World!'
    END
    @mock_feature = mock(RailsFeature)
    @mock_feature.stub!(:scenarios).and_return([])
  end
  context ", New" do
    
    before(:each) do
      
      @scenario = RailsScenario.new({
        :title   => "With a blank Object", 
        :body    => @scenario_body,
        :parent  => @mock_feature
      }).collect_steps
      
    end
    
    it "has a title" do
      @scenario.title.should eql("With a blank Object")
    end
    
    it "has a body" do
      @scenario.body.should eql(@scenario_body)
    end
    
    it "has a given_scenario_keyword" do
      @scenario.given_scenario_keyword.should eql("GivenScenario:")
    end
    
    it "has a test_name" do
      @scenario.test_name.should == "test_WithABlankObject"
    end
    
    it "has steps" do
      @scenario.steps.should_not be_empty
    end
    
    it "belongs to a feature" do
      @scenario.parent.should eql(@mock_feature)
    end
    
    describe "as string" do
      it "exposes itself as a string" do
        step = mock(RailsStep, :to_s => "step_definition")
        steps = [step, step]
        @scenario.stub!(:steps).and_return(steps)
        expected = <<-END
      def test_WithABlankObject
        step_definition; step_definition
      end
        END
        @scenario.to_s.ignore_whitespace.should eql(expected.ignore_whitespace)
      end
    end
    
    it "finds 'Given a blank Object' step" do
      step = @scenario.steps.detect {|s| s.title == 'Given a blank Object'}
      step.should_not be_nil
    end
    
    context "with Given a blank Object step" do
      before(:each) do
        @step = @scenario.steps.detect {|s| s.title == 'Given a blank Object'}
      end
      
      it "has first_part: Given_a_blank_Object" do
        @step.first_part.should eql("Given_a_blank_Object")
      end
      
      it "has no args" do
        @step.should have(0).args
      end
    end
    
    context "with 'It should return 'Hello, World!'' step" do
      before(:each) do
        @step = @scenario.steps.detect {|s| s.title == "It should return 'Hello, World!'"}
      end
      
      it "has first_part: Given_a_blank_Object" do
        @step.first_part.should eql("It_should_return___")
      end
      
      it "has arg: 'Hello, World!'" do
        @step.args[0].should eql('Hello, World!')
      end
    end
    
    describe "verification" do
      
      context "failing" do
        before(:each) do
          @results = <<-END
          (in /Users/mhennemeyer/Projekte/features/spec/Rails/Resources/railsapp)
          /System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby -I"lib:test" "/Library/Ruby/Gems/1.8/gems/rake-0.8.7/lib/rake/rake_test_loader.rb" "test/integration/feature_test.rb" 
          Loaded suite /Library/Ruby/Gems/1.8/gems/rake-0.8.7/lib/rake/rake_test_loader
          Started
          F.F
          Finished in 0.045529 seconds.

            1) Failure:
          test_WithABlankObject(FeatureTest) [/test/integration/feature_test.rb:8]:
          <false> is not true.

            2) Failure:
          test_AnotherFailingOne(FeatureTest) [/test/integration/feature_test.rb:16]:
          <false> is not true.

          3 tests, 3 assertions, 2 failures, 0 errors
          rake aborted!
          Command failed with status (1): [/System/Library/Frameworks/Ruby.framework/...]

          (See full trace by running task with --trace)
          END
          @mock_feature.should_receive(:test_case_name).and_return("FeatureTest")
          @scenario.verify_status(@results)
        end

        it "verifies its status" do
          @scenario.passed?.should be_false
        end
      end
      
      context "passing" do
        before(:each) do
          @results = <<-END
          (in /Users/mhennemeyer/Projekte/features/spec/Rails/Resources/railsapp)
          /System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby -I"lib:test" "/Library/Ruby/Gems/1.8/gems/rake-0.8.7/lib/rake/rake_test_loader.rb" "test/integration/feature_test.rb" 
          Loaded suite /Library/Ruby/Gems/1.8/gems/rake-0.8.7/lib/rake/rake_test_loader
          Started
          ...
          Finished in 0.045529 seconds.
          END
          @mock_feature.should_receive(:test_case_name).and_return("FeatureTest")
          @scenario.verify_status(@results)
        end

        it "verifies its status" do
          @scenario.passed?.should be_true
        end
      end
      
      
      describe "#to_html" do
        it "does something" do
          @mock_feature.should_receive(:scenario_keyword).and_return("Scenario:")
          @scenario.should_receive(:steps).and_return([mock(Step, :to_html => "steps")])
          expected = <<-END
        <div class="scenario failed">
          <h2 class="scenario_title">Scenario: With a blank Object</h2>
          steps
        </div>
          END
          @scenario.to_html.ignore_whitespace.should == expected.ignore_whitespace
        end
      end
    end
    
  end
end