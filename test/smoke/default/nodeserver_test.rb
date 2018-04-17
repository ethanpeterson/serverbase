# # encoding: utf-8

# Inspec test for recipe serverbase::nodeserver

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe directory('/srv/www/doorsinfo') do
  it { should be_directory }
  it { should be_owned_by 'www-data' }
  it { should be_grouped_into 'www-data' }
end

# verify nginx serice
describe service('doorsinfo') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/srv/www/doorsinfo/server.js') do
  it { should be_file }
end
