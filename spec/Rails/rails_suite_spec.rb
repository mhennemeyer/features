require File.dirname(__FILE__) + '/spec_helper'

describe RailsSuite do
  before(:each) do
    @feature_files_path = File.dirname(__FILE__) + "/Resources"
    @suite = RailsSuite.new({
      :feature_files_path         => @feature_files_path,
      :feature_file_suffix        => "feature",
      :test_cases_file            => @feature_files_path + "/FeatureTestCases.rb",
      :project_name               => "Rails Features"
    })
  end
  
  it "has a feature_keyword" do
    @suite.feature_keyword.should eql("Feature:")
  end
  
  it "has a scenario_keyword" do
    @suite.scenario_keyword.should eql("Scenario:")
  end
  
  it "has a given_scenario_keyword" do
    @suite.given_scenario_keyword.should eql("GivenScenario:")
  end
  
  it "has a project_name" do
    @suite.project_name.should == "Rails Features"
  end

  it "has a test_cases_file" do
    @suite.test_cases_file.should eql(@feature_files_path + "/FeatureTestCases.rb")
  end
    
  it "has feature files" do
    @suite.feature_files.should_not be_nil
  end
  
  it "inits feature files path from hash passed to .new" do
    @suite.feature_files_path.should eql(@feature_files_path)
  end
  
  it "has feature file suffix" do
    @suite.feature_file_suffix.should_not be_nil
  end
  
  it "finds HelloWorld.feature feature files" do
    @suite.feature_files.should include(@feature_files_path + "/HelloWorld.feature")
  end
  
  it "finds OtherFeatureFile.feature feature files" do
    @suite.feature_files.should include(@feature_files_path + "/OtherFeatureFile.feature")
  end
  
  it "won't find other files in location" do
    @suite.feature_files.should_not include(@feature_files_path + "/other.file")
  end
  
  it "reads the HelloWorld.feature feature file" do
    File.stub!(:open)
    File.should_receive(:open).with(@feature_files_path + "/HelloWorld.feature")
    @suite.all_feature_files_as_strings
  end
  
  it "reads the OtherFeatureFile.feature feature file" do
    File.stub!(:open)
    File.should_receive(:open).with(@feature_files_path + "/OtherFeatureFile.feature")
    @suite.all_feature_files_as_strings
  end
  
  it "stores content of HelloWorld.feature as string in feature_files array" do
    content_of_feature_file = ""
    File.open(@feature_files_path + "/HelloWorld.feature") do |f|
      f.readlines.each do |l|
        content_of_feature_file << l
      end
    end
    @suite.feature_files_as_strings.should include(content_of_feature_file)
  end
  
  it "stores content of OtherFeatureFile.feature as string in feature_files array" do
    content_of_feature_file = ""
    File.open(@feature_files_path + "/OtherFeatureFile.feature") do |f|
      f.readlines.each do |l|
        content_of_feature_file << l
      end
    end
    @suite.feature_files_as_strings.should include(content_of_feature_file)
  end
  
  context "parse_features" do
    before(:each) do
      @suite.parse_features
    end
    it "has features" do
      @suite.features.should_not be_nil
    end

    it "finds Say Hello World Feature" do
      @suite.features.detect {|f| f.title == "Say Hello World"}.should_not be_nil
    end

    it "finds Say Hello Universe Feature" do
      @suite.features.detect {|f| f.title == "Say Hello World"}.should_not be_nil
    end

    it "finds Say Hello Feature" do
      @suite.features.detect {|f| f.title == "Say Hello"}.should_not be_nil
    end
  end
  
  describe "parse_feature_scenarios" do
    it "sends parse_scenarios  message to features" do
      mock_feature_1 = mock_feature_2 = mock(Feature)
      mock_feature_1.should_receive(:parse_scenarios)
      mock_feature_2.should_receive(:parse_scenarios)
      @suite.should_receive(:features).and_return([mock_feature_1, mock_feature_2])
      @suite.parse_feature_scenarios
    end
  end
  
  context "with features and scenarios parsed" do
    
    before(:each) do
      @suite.parse_features
      @suite.parse_feature_scenarios
    end
    
    describe "as string" do
      
      before(:each) do
        feature = mock(RailsFeature, :to_s => "feature_def")
        features = [feature, feature]
        @suite.stub!(:features).and_return(features)
      end
      
      it "chains all features as strings" do
        @suite.to_s.ignore_whitespace.should eql("feature_def feature_def")
      end
    end
  end
  
  describe "#run" do
    before(:each) do
      @suite.run
    end
    
    it "overwrites its test_cases_file with itself as string" do
      content = File.open(@suite.test_cases_file) {|f| f.readlines}
      content = ""
      File.open(@suite.test_cases_file) do |f|
        f.readlines.each do |l|
          content << l
        end
      end
      content.should eql(@suite.to_s)
    end
  end
  
  context "validation" do
    it "won't accept two features with the same test_case_names" do
      @suite.parse_features
      @suite.features << mock(Feature, :test_case_name => "SayHelloTest")
      @suite.should_not be_valid
    end
  end
  
  context "Result parsing" do
    
    before(:each) do
      @results = <<-END
      test_WithABlankObject(SayHelloUniverseTest)
      END
    end
    
    it "verifies that SayHello:WithACustomObject passes" do
      @suite.parse_results(@results)
      @suite.features.detect {|f| f.title == "Say Hello"}.
        scenarios.detect {|s| s.title == "With a custom Object"}.passed?.should be_true
    end
    
    it "verifies that SayHelloUniverse:WithABlankObject fails" do
      @suite.parse_results(@results)
      @suite.features.detect {|f| f.title == "Say Hello Universe"}.
        scenarios.detect {|s| s.title == "With a blank Object"}.passed?.should be_false
    end
    
    it "knows if it has passed or failed" do
      @suite.parse_results(@results)
      @suite.passed?.should be_false
    end
    
    describe "#html" do
      before(:each) do
        @suite.parse_results(@results)
        @html = @suite.html
      end
      
      it "renders Feature: Say Hello World" do
        puts @html
        @html.should =~ /Feature:\sSay\sHello\sWorld/
      end
      
      it "renders project_name" do
        @html.should =~ /Rails\sFeatures/
      end
      
      it "show in browser" do
        # %x(touch '/tmp/out.html' && echo '#{@html}' > /tmp/out.html && open '/tmp/out.html' )
      end
      
      
    end
    
  end
end