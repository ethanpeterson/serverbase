# frozen_string_literal: true

require 'chefspec'
require 'chefspec/berkshelf'

# load all custom matchers
Dir.glob("#{File.dirname(__FILE__)}/custom_matchers/*_matcher.rb").each do |matcher_implementation| require matcher_implementation end

# Dir['unit/recipes/*_spec.rb'].each do |f| require File.expand_path(f) end

at_exit { ChefSpec::Coverage.report! }
