require 'rubygems'
require 'spec'
require File.dirname(__FILE__) + '/../features.rb'

class String
  def ignore_whitespace
    self.strip.gsub(/\s+/, " ")
  end
end