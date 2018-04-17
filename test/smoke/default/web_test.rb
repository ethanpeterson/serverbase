# # encoding: utf-8

# Inspec test for recipe serverbase::web

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/etc/nginx/sites-enabled/doorsinfo') do
  it { should be_file }
end

describe file('/etc/nginx/sites-enabled/doorsinfo') do
  its('content') { should match(%r{proxy_pass http://127.0.0.1:3000}) }
end

describe package 'nginx' do
  it { should be_installed }
end

# verify nginx serice
describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

# get localhost
describe command 'wget -qSO- --spider localhost' do
  its('stderr') { should match %r{HTTP/1\.1 200 OK} }
end

describe port 80 do
  it { should be_listening }
end
