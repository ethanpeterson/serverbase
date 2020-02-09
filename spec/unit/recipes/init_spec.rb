#
# Cookbook:: serverbase
# Spec:: init
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# frozen_string_literal: true

require 'spec_helper'

describe 'serverbase::init' do
  let(:chef_run) do
    # for a complete list of available platforms and versions see:
    # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
    runner.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  context 'When the swap file is created' do
    it 'it is equal to 1024 mb in size' do
      expect(chef_run).to create_swap('/mnt/swap').with(size: 1024)
      # skip ''
    end
  end

  context 'When the apt_update is set' do
    it 'its frequency should be 86_400' do
      expect(chef_run).to periodic_apt_update('daily').with(frequency: 86400)
    end
  end

  context 'When the yum_update is set' do
    it 'it should not include mongodb' do
      expect(chef_run).to run_execute('yum update -y -x mongodb\* -x nginx\*')
    end
  end
end
