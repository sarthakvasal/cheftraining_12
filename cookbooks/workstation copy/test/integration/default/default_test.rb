# Chef InSpec test for recipe workstation::default

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe 'workstation::default' do
  describe package('tree') do
    it { should be_installed }
  end
  describe package('git') do
    it { should be_installed }
  end
  describe file('/etc/motd') do
    it { should be_owned_by 'root' }
  end
end
