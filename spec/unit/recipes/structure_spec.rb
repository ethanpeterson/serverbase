#
# Cookbook:: serverbase
# Spec:: structure
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# frozen_string_literal: true

require 'spec_helper'

describe 'serverbase::structure' do
  let(:chef_run) do
    # for a complete list of available platforms and versions see:
    # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
    ChefSpec::ServerRunner.new(platform: 'amazon', version: '2018.03') do |node|
      node.override['serverbase']['nodeserver']['web_root'] = '/srv/www'
      node.override['serverbase']['web']['site_name'] = 'doorsinfo'
      node.override['nginx']['user'] = 'www-data'
      node.override['nginx']['group'] = 'www-data'
      node.override['serverbase']['nodeserver']['starter_script'] = 'server.js'
    end.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  context 'When the nginx directory is created' do
    it 'it should be equal to \'/srv/www\'' do
      expect(chef_run).to create_directory('/srv/www/doorsinfo').with(
        recursive: true,
        group: 'www-data'
      )
    end
  end

  context 'When the node.js index file is created' do
    it 'it should be named \'server.js\'' do
      expect(chef_run).to create_cookbook_file('/srv/www/doorsinfo/server.js').with(
        user: 'www-data',
        group: 'www-data',
        source: 'server.js'
      )
    end
  end
end
