#
# Cookbook:: serverbase
# Spec:: nodeserver
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# frozen_string_literal: true

require 'spec_helper'

describe 'serverbase::nodeserver' do
  let(:chef_run) do
    # for a complete list of available platforms and versions see:
    # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
      node.override['nodejs']['version'] = '10.3.0'
      node.override['nginx']['group'] = 'www-data'
    end.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'includes the nginx cookbook' do
    expect(chef_run).to include_recipe('nvm')
  end

  context 'When NVM is installed' do
    it 'it should have a version of 10.3.0' do
      expect(chef_run).to install_nvm('10.3.0').with(
        from_source: false,
        alias_as_default: true,
        group: 'www-data'
      )
    end
  end
end
