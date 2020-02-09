#
# Cookbook:: serverbase
# Spec:: shutdown
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# frozen_string_literal: true

require 'spec_helper'

describe 'serverbase::shutdown' do
  # assert the directory exists
  before do
    # allow(Dir).to receive(:exist?).and_call_original
    allow(Dir).to receive(:exist?).with('/srv/www/doorsinfo').and_return(true)
  end

  let(:chef_run) do
    # for a complete list of available platforms and versions see:
    # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
      node.override['serverbase']['nodeserver']['service_name'] = 'doorsinfod'
      node.override['serverbase']['nodeserver']['web_root'] = '/srv/www'
      node.override['serverbase']['web']['site_name'] = 'doorsinfo'
    end.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  context 'When the server is being shutdown' do
    it 'it should stop the custom nodejs service' do
      expect(chef_run).to stop_service('doorsinfod')
    end

    it 'it should delete all the relevant website files' do
      expect(chef_run).to delete_directory('/srv/www/doorsinfo').with(recursive: true)
    end
  end
end
