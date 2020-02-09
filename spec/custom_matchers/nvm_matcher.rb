# frozen_string_literal: true

module NvmInstallMatcher
  class NvmInstallMatcher
    def initialize(expected_identity)
      @expected_identity = expected_identity
      @resource_name = 'nvm_install'
      @expected_action = 'create'
    end

    def matches?(runner)
      @runner = runner

      if resource
        ChefSpec::Coverage.cover!(resource)
        unmatched_parameters.empty?
      end
    end

    def with(parameters = {})
      params.merge!(parameters)
      self
    end

    def failure_message
      if resource
        if unmatched_parameters.empty?
          %(expected "#{resource}" to be run at converge time)
        else
          message = %(expected "#{resource}" to have parameters:) \
            "\n\n" \
            '  ' + unmatched_parameters.collect { |parameter, h|
              msg = "#{parameter} #{h[:expected].inspect}, was #{h[:actual].inspect}"
              diff = ::RSpec::Matchers::ExpectedsForMultipleDiffs.from(h[:expected]) \
                                                                 .message_with_diff(message, ::RSpec::Expectations.differ, h[:actual])
              msg += diff if diff
              msg
            }.join("\n  ")
        end
      else
        %(expected "#{@resource_name}[#{@expected_identity}]") \
          " with action :#{@expected_action} to be in Chef run." \
          " Other #{@resource_name} resources:" \
          "\n\n" \
          '  ' + similar_resources.map(&:to_s).join("\n  ") + "\n "
      end
    end

    def failure_message_when_negated
      if resource
        %(expected "#{resource}" actions #{resource.performed_actions.inspect} to not exist)
      else
        %(expected "#{resource}" to not exist)
      end
    end

    private

    def unmatched_parameters
      return @_unmatched_parameters if @_unmatched_parameters

      @_unmatched_parameters = {}

      params.each do |parameter, expected|
        next if matches_parameter?(parameter, expected)
        @_unmatched_parameters[parameter] = {
          expected: expected,
          actual:   safe_send(parameter)
        }
        # end
      end

      @_unmatched_parameters
    end

    def matches_parameter?(parameter, expected)
      value = safe_send(parameter)
      # print value
      if parameter == :source
        # Chef 11+ stores the source parameter internally as an Array
        Array(expected) == Array(value)
      elsif expected.is_a?(Class)
        # Ruby can't compare classes with ===
        expected == value
      else
        expected === value
      end
    end

    def safe_send(parameter)
      resource.send(parameter)
    rescue NoMethodError
      nil
    end

    #
    # Any other resources in the Chef run that have the same resource
    # type. Used by {failure_message} to be ultra helpful.
    #
    # @return [Array<Chef::Resource>]
    #
    def similar_resources
      @_similar_resources ||= @runner.find_resources(@resource_name)
    end

    #
    # Find the resource in the Chef run by the given class name and
    # resource identity/name.
    #
    # @see ChefSpec::SoloRunner#find_resource
    #
    # @return [Chef::Resource, nil]
    #
    def resource
      @_resource ||= @runner.find_resource(@resource_name, @expected_identity, @expected_action)
    end

    #
    # The list of parameters passed to the {with} matcher.
    #
    # @return [Hash]
    #
    def params
      @_params ||= {}
    end
  end

  def install_nvm(expected_identity)
    NvmInstallMatcher.new(expected_identity)
  end
end

RSpec.configure do |config|
  config.include NvmInstallMatcher
end
