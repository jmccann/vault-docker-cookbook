# # encoding: utf-8

# Inspec test for recipe vault-docker::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe port(8200) do
  it { should be_listening }
end

describe command('docker logs vault') do
  # Has mlock enabled and working
  its(:stderr) { should_not include("Couldn't start vault with IPC_LOCK") }

  # Using file storage backend
  its(:stdout) { should include('Storage: file') }

  # Using TLS
  its(:stdout) { should include('tls: "enabled"') }
end

describe command('vault init -tls-skip-verify') do
  its(:stdout) { should include('Vault initialized with 5 keys') }
end
