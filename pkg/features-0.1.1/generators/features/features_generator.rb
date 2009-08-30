class FeaturesGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory("test/features")
      m.file("run_features.rb", "test/features/run_features.rb")
      m.file("HelloWorld.feature", "test/features/HelloWorld.feature")
      
      m.directory("test/features/support")
      m.file("features_helper.rb", "test/features/support/features_helper.rb")
      m.file("features_test_case_class.rb", "test/features/support/features_test_case_class.rb")
      m.file("test_cases_file.rb", "test/features/support/test_cases_file.rb")
      m.file("custom_steps.rb", "test/features/support/custom_steps.rb")
    end
  end
end