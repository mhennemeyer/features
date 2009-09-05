class RailsSuite < Suite
  attr_reader :feature_files,              :feature_files_path, 
              :feature_file_suffix,        :feature_files_as_strings,
              :features,                   :test_cases_file,  
              :feature_keyword,            :scenario_keyword,
              :project_name,               :passed, 
              :given_scenario_keyword,     :features_helper,
              :follow_up_keyword
  
  def initialize(hash)
    @feature_files_path          = hash[:feature_files_path]
    @feature_file_suffix         = hash[:feature_file_suffix] || "feature"
    @test_cases_file             = hash[:test_cases_file]
    @features_helper             = File.expand_path(hash[:features_helper])
    @feature_keyword             = hash[:feature_keyword] || "Feature:"
    @scenario_keyword            = hash[:scenario_keyword] || "Scenario:"
    @given_scenario_keyword      = hash[:given_scenario_keyword] || "GivenScenario:"
    @project_name                = hash[:project_name] || "Features"
    @follow_up_keyword           = hash[:follow_up_keyword] || "And"
    @feature_files               = all_feature_files
    @feature_files_as_strings    = all_feature_files_as_strings
  end
  
  def parse_features(klass=RailsFeature)
    title_body_arr = Parser.title_and_body_by_keyword_from_string({
      :string => feature_files_as_strings.join(" "),
      :keyword => feature_keyword
    })
    @features = title_body_arr.map do |hash| 
      klass.new(hash.update({
        :keyword => feature_keyword, 
        :scenario_keyword => scenario_keyword,
        :given_scenario_keyword => given_scenario_keyword,
        :follow_up_keyword => follow_up_keyword}))
    end
  end
  
  def to_s
    <<-END
require "#{features_helper}"

#{features.map {|f| f.to_s }.join("\n")}
    END
  end
end