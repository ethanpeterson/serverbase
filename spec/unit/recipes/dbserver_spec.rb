#
# Cookbook:: serverbase
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# frozen_string_literal: true

require 'spec_helper'

describe 'serverbase::dbserver' do
  let(:chef_run) do
    # for a complete list of available platforms and versions see:
    # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
      node.override['serverbase']['mongoserver']['instance_name'] = 'doorsinfo'
    end.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'includes the nginx cookbook' do
    expect(chef_run).to include_recipe('sc-mongodb::default')
  end

  context 'When MongoDB is installed' do
    it 'it should have an instance name of \'doorsinfo\'' do
      expect(chef_run).to create_mongodb_instance('doorsinfo')
      # skip ''
    end
  end
end
