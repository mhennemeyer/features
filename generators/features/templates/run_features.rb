require "rubygems"
require "features"

current_dir = File.dirname(File.expand_path(__FILE__))
suite = RailsSuite.new({
  :feature_files_path => current_dir,
  :test_cases_file    => current_dir + "/support/test_cases_file.rb",
  :features_helper    => current_dir + "/support/features_helper.rb"
})

suite.run

results = `ruby #{suite.test_cases_file}`

puts results

suite.parse_results_and_open_in_safari(results)