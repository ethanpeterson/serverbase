# frozen_string_literal: true

#
# Matches, if mongodb_instance resource was called
# source: https://semaphoreci.com/community/tutorials/how-to-use-custom-rspec-matchers-to-specify-behaviour
#
# @example This is an example
#   expect(chef_run).to create_mongodb_instance('INSTANCE_NAME')
#
# @param [String] instance_name
#   the mongodb instance name
#
# @return true or false
#
module CreateMongoDbInstanceMatcher
  class CreateMongoDbInstanceMatcher
    def initialize(instance_name)
      @instance_name = instance_name
    end

    def matches?(str)
      @str = str
      !@instance_name.empty?
      # JsonPath.new(@instance_name).on(str).count > 0
    end

    def failure_message
      %("Expected path #{@instance_name.inspect} to match in:\n") +
        JSON.pretty_generate(JSON.parse(@str))
    end

    def failure_message_when_negated
      %("Expected path #{@instance_name.inspect} not to match in:\n") +
        JSON.pretty_generate(JSON.parse(@str))
    end
  end

  def create_mongodb_instance(instance_name)
    CreateMongoDbInstanceMatcher.new(instance_name)
  end
end

RSpec.configure do |config|
  config.include CreateMongoDbInstanceMatcher
end
