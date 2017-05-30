name 'vault-docker'
maintainer 'Jacob McCann'
maintainer_email 'jacob.mccann2@target.com'
license 'Apache-2.0'
description 'Installs/Configures vault-docker'
long_description 'Installs/Configures vault-docker'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

source_url 'https://github.com/jmccann/vault-docker-cookbook'
issues_url 'https://github.com/jmccann/vault-docker-cookbook/issues'

depends 'jmccann-docker-host', '~> 2.0'

supports 'ubuntu', '>= 16.04'
