# # encoding: utf-8

# Inspec test for recipe vault-docker::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe port(8200) do
  it { should be_listening }
end
