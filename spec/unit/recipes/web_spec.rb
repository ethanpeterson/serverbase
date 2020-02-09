#
# Cookbook:: serverbase
# Spec:: web
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# frozen_string_literal: true

require 'spec_helper'

describe 'serverbase::web' do
  # assert the file doesn't exist
  before do
    allow(File).to receive(:exist?).and_call_original
    allow(File).to receive(:exist?).with('/etc/profile.d/nginx.sh').and_return(false)
  end

  let(:chef_run) do
    # for a complete list of available platforms and versions see:
    # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
      node.override['serverbase']['web']['site_name'] = 'doorsinfo'
      node.override['serverbase']['nodeserver']['web_root'] = '/srv/www'
      node.override['serverbase']['nodeserver']['temp_path'] = 'temp'
      node.override['serverbase']['web']['ssl_combined_cert_path'] = '/etc/ssl/mycert.CA.combined.crt'
      node.override['serverbase']['web']['ssl_cert_key_path'] = '/etc/ssl/mycert.com.key'
      node.override['serverbase']['web']['ssl_dhparam_path'] = '/etc/ssl/dhparam.pem'
      node.override['serverbase']['web']['ssl_cert_trust_chain_path'] = '/etc/ssl/rootCAcertfilename.crt'
    end.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'includes the nginx cookbook' do
    expect(chef_run).to include_recipe('nginx')
  end

  context 'When the nginx server is installed' do
    it 'it should not include the default site' do
      expect(chef_run).to disable_nginx_site('default')
    end
  end

  context 'When nginx website configuration is created' do
    it 'it should create the site.conf template' do
      expect(chef_run).to create_nginx_site('doorsinfo').with(
        template: 'site.conf.erb',
        # variables: (
        #   temp_path: '/srv/www/temp'
        #   ssl_cert_path: '/etc/ssl/mycert.CA.combined.crt'
        #   ssl_cert_key_path: '/etc/ssl/mycert.com.key'
        #   ssl_dhparam: '/etc/ssl/dhparam.pem'
        #   ssl_cert_trust_chain_path: '/etc/ssl/rootCAcertfilename.crt'
        # ),
        name: 'doorsinfo'
      )
      expect(chef_run).to enable_service('nginx')
      # expect(chef_run).to notify('service[nginx]').to(:restart).delayed
    end
  end

  context 'When the nginx server is configured' do
    it 'it should start the service' do
      expect(chef_run).to enable_service('nginx')
      expect(chef_run).to start_service('nginx')
    end
  end

  context 'The nginx.sh file should be created' do
    it 'if it doesn\'t exist' do
      expect(chef_run).to create_file('/etc/profile.d/nginx.sh')
    end
  end
end
