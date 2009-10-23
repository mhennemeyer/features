require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('features', '0.3.0') do |p|
  p.description    = "Plaintext User Stories Parser supporting native programming languages. Especially Objective-C"
  p.url            = "http://features.rubyforge.org"
  p.author         = "Matthias Hennemeyer"
  p.email          = "mhennemeyer@me.com"
  p.ignore_pattern = ["spec/**/*","website/**/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }