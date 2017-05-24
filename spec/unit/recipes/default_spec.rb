#
# Cookbook:: vault-docker
# Spec:: default
#
# Copyright:: 2017, Jacob McCann
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


require 'spec_helper'

describe 'vault-docker::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    cached(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'pulls vault image' do
      expect(chef_run).to pull_docker_image 'vault'
    end

    it 'starts vault container' do
      expect(chef_run).to run_docker_container('vault')
        .with(command: 'server', port: '8200:8200')
    end
  end

  context 'When attributes are set, on an Ubuntu 16.04' do
    cached(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node, _server|
        node.normal['vault']['config']['vault_local_config'] = '{"backend": {"file": {"path": "/vault/file"}}, "default_lease_ttl": "168h", "max_lease_ttl": "720h"}'
        node.normal['vault']['config']['vault_dev_root_token_id'] = 'abcd1234'
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'pulls vault image' do
      expect(chef_run).to pull_docker_image 'vault'
    end

    it 'starts vault container' do
      expect(chef_run).to run_docker_container('vault')
        .with(command: 'server')
    end

    describe 'vault container environment' do
      let(:vault_env) do
        chef_run.docker_container('vault').env
      end

      it 'sets vault loval config' do
        expect(vault_env).to include('VAULT_LOCAL_CONFIG={"backend": {"file": {"path": "/vault/file"}}, "default_lease_ttl": "168h", "max_lease_ttl": "720h"}')
      end

      it 'sets vault dev root token id' do
        expect(vault_env).to include('VAULT_DEV_ROOT_TOKEN_ID=abcd1234')
      end
    end
  end
end
