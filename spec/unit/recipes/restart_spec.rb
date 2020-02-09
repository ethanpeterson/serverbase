#
# Cookbook:: serverbase
# Spec:: restart
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# frozen_string_literal: true

require 'spec_helper'

describe 'serverbase::restart' do
  let(:chef_run) do
    # for a complete list of available platforms and versions see:
    # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
      node.override['serverbase']['nodeserver']['service_name'] = 'doorsinfod'
    end.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  context 'When the server\'s web services are restarted' do
    it 'it should start nginx' do
      nginx_service = chef_run.service('nginx')
      expect(chef_run).to restart_service('nginx')
      expect(nginx_service).to notify('service[doorsinfod]').to(:restart)
    end

    it 'it should start node.js' do
      node_service = chef_run.service('doorsinfod')
      expect(node_service).to do_nothing
    end
  end
end
