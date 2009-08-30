# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{features}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthias Hennemeyer"]
  s.date = %q{2009-08-30}
  s.description = %q{Plaintext User Stories Parser supporting native programming languages.}
  s.email = %q{mhennemeyer@me.com}
  s.extra_rdoc_files = ["README.markdown", "lib/ObjC/objc_feature.rb", "lib/ObjC/objc_scenario.rb", "lib/ObjC/objc_step.rb", "lib/ObjC/objc_suite.rb", "lib/Rails/rails_feature.rb", "lib/Rails/rails_scenario.rb", "lib/Rails/rails_step.rb", "lib/Rails/rails_suite.rb", "lib/feature.rb", "lib/features.rb", "lib/objc.rb", "lib/parser.rb", "lib/rails.rb", "lib/scenario.rb", "lib/step.rb", "lib/string_extension.rb", "lib/suite.rb"]
  s.files = ["Manifest", "README.markdown", "Rakefile", "generators/features/USAGE", "generators/features/features_generator.rb", "generators/features/templates/HelloWorld.feature", "generators/features/templates/custom_steps.rb", "generators/features/templates/features_helper.rb", "generators/features/templates/features_test_case_class.rb", "generators/features/templates/run_features.rb", "generators/features/templates/test_cases_file.rb", "lib/ObjC/objc_feature.rb", "lib/ObjC/objc_scenario.rb", "lib/ObjC/objc_step.rb", "lib/ObjC/objc_suite.rb", "lib/Rails/rails_feature.rb", "lib/Rails/rails_scenario.rb", "lib/Rails/rails_step.rb", "lib/Rails/rails_suite.rb", "lib/feature.rb", "lib/features.rb", "lib/objc.rb", "lib/parser.rb", "lib/rails.rb", "lib/scenario.rb", "lib/step.rb", "lib/string_extension.rb", "lib/suite.rb", "features.gemspec"]
  s.homepage = %q{http://features.rubyforge.org}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Features", "--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{features}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Plaintext User Stories Parser supporting native programming languages.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
