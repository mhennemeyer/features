require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('features', '0.1.2') do |p|
  p.description    = "Plaintext User Stories Parser supporting native programming languages."
  p.url            = "http://features.rubyforge.org"
  p.author         = "Matthias Hennemeyer"
  p.email          = "mhennemeyer@me.com"
  p.ignore_pattern = ["spec/**/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }