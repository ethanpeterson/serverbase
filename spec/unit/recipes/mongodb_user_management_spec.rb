#
# Cookbook:: serverbase
# Spec:: mongodb_user_management
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# frozen_string_literal: true

require 'spec_helper'

describe 'serverbase::mongodb_user_management' do
  before do
    Chef::Recipe.any_instance.stub(:search).and_return(
      [
        { # https://github.com/chefspec/chefspec#search OR https://github.com/chefspec/chefspec/issues/63#issuecomment-287801140
          'environment' =>
          {
            'MONGODB_ADMIN_PASSWORD' => 'password123',
            'APP_ADMIN_PASSWORD' => 'password456'
          }
        }
      ]
    )
  end

  let(:chef_run) do
    # for a complete list of available platforms and versions see:
    # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
    runner.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'includes the nginx cookbook' do
    expect(chef_run).to include_recipe('sc-mongodb::user_management')
  end

  # context 'When MongoDB users are created' do
  #   it 'it should create the admin account' do
  #     skip ''
  #   end

  #   it 'it should create the primary admin database instance' do
  #     skip ''
  #   end

  #   it 'it should create the primary user account' do
  #     skip ''
  #   end

  #   it 'it should create the secondary database instance' do
  #     skip ''
  #   end

  #   it 'it should create the secondary user account' do
  #     skip ''
  #   end
  # end
end
