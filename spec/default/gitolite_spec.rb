require 'spec_helper'

%w{
  git
  perl
}.each do |p|
  describe package(p) do
    it { should be_installed }
  end
end

%w{
  perl-Time-HiRes
  perl-Data-Dumper
}.each do |p|
  describe package(p), :if => os[:family] == 'redhat' do
    it { should be_installed }
  end
end

describe group('git') do
  it { should exist }
end

describe user('git') do
  it { should exist }
  it { should belong_to_primary_group 'git' }
  it { should have_home_directory '/srv/git' }
end


describe file('/srv/git/.ssh') do
  it { should be_directory }
  it { should be_mode '700' }
  it { should be_owned_by 'git' }
  it { should be_grouped_into 'git' }
end

describe file('/srv/git/.ssh/config') do
  it { should be_file }
  it { should be_mode '600' }
  it { should be_owned_by 'git' }
  it { should be_grouped_into 'git' }
  its(:content) { should match /Host localhost/ }
  its(:content) { should match /HashKnownHosts no/ }
  its(:content) { should match /UserKnownHostsFile \/dev\/null/ }
  its(:content) { should match /StrictHostKeyChecking no/ }
  its(:content) { should match /GSSAPIAuthentication no/ }
  its(:content) { should match /PasswordAuthentication no/ }
end

describe file('/srv/git/.gitconfig') do
  it { should be_file }
  it { should be_mode '600' }
  it { should be_owned_by 'git' }
  it { should be_grouped_into 'git' }
  its(:content) { should match /name = Git Service/ }
  its(:content) { should match /email = git@localhost\.localdomain/ }
  its(:content) { should match /default = current/ }
end

describe file('/srv/git/.gitolite.rc') do
  it { should be_file }
  it { should be_mode '640' }
  it { should be_owned_by 'git' }
  it { should be_grouped_into 'git' }
end

describe file('/usr/local/gitolite') do
  it { should be_directory }
  it { should be_mode '755' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/srv/git/.gitolite') do
  it { should be_directory }
  it { should be_mode '750' }
  it { should be_owned_by 'git' }
  it { should be_grouped_into 'git' }
end


describe file('/etc/ansible/facts.d/gitolite.fact') do
  it { should be_file }
  it { should be_mode '644' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match /^version = v3\.6\.3$/ }
  its(:content) { should match /^user_name = "git"$/ }
  its(:content) { should match /^user_home = "\/srv\/git"$/ }
  its(:content) { should match /^install_dir = "\/usr\/local\/gitolite"$/ }
  its(:content) { should match /^vendor = "Silpion"$/ }
  its(:content) { should match /^vendor_url = "http:\/\/silpion.de"$/ }
  its(:content) { should match /^vendor_github = "https:\/\/github\.com\/silpion"$/ }
  its(:content) { should match /^role_version = "2\.0\.0"$/ }
end

# write up RSpec integration tests here
#   see: http://serverspec.org/resource_types.html
