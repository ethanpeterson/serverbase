#
# Cookbook:: serverbase
# Spec:: services
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# frozen_string_literal: true

require 'spec_helper'

describe 'serverbase::services' do
  before do
    Chef::Recipe.any_instance.stub(:search).and_return(
      [
        {
          'environment' =>
          {
            'NODE_ENV' => 'production'
          }
        }
      ]
    )
  end

  let(:chef_run) do
    # for a complete list of available platforms and versions see:
    # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
      node.override['serverbase']['nodeserver']['service_path'] = '/etc/rc.d/init.d/'
      node.override['serverbase']['nodeserver']['service_name'] = 'doorsinfod'
      node.override['serverbase']['nodeserver']['web_root'] = '/srv/www'
      node.override['serverbase']['web']['site_name'] = 'doorsinfo'
      node.override['serverbase']['nodeserver']['version'] = '12.13.0'
      node.override['serverbase']['nodeserver']['node_path'] = '/usr/local/src/nvm/versions/node/v12.13.0/bin'
    end.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  context 'When Node server service file created' do
    it 'it should exist' do
      expect(chef_run).to create_template('/etc/rc.d/init.d/doorsinfod')
      nginx_service = chef_run.service('doorsinfod')
      expect(nginx_service).to notify('service[nginx]').to(:restart).delayed
    end

    it 'it should start the nginx service' do
      node_service = chef_run.service('nginx')
      expect(node_service).to do_nothing
    end
  end
end
