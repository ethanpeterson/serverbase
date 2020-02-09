#
# Cookbook:: serverbase
# Spec:: users
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# frozen_string_literal: true

require 'spec_helper'

describe 'serverbase::users' do
  before do
    stub_command('getent passwd www-data').and_return(nil)
  end

  let(:chef_run) do
    # for a complete list of available platforms and versions see:
    # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
      node.override['chef']['opsworks']['user'] = 'ec2-user'
      node.override['nginx']['user'] = 'www-data'
      node.override['nginx']['group'] = 'www-data'
    end.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  context 'When the \'www-data\' group is created' do
    it 'it should include the user \'ec2-user\'' do
      expect(chef_run).to create_group('www-data').with(members: ['ec2-user'])
    end
  end

  context 'When the nginx group is created' do
    it 'it should include the user \'ec2-user\'' do
      expect(chef_run).to create_group('www-data').with(members: ['ec2-user'])
    end
  end

  context 'When the user \'www-data\' is created' do
    it 'it should be added to the \'www-data\' group' do
      expect(chef_run).to create_user('www-data').with(
        uid: 4002,
        gid: 'www-data',
        shell: '/bin/bash'
      )
    end
  end
end
