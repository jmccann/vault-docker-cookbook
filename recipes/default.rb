#
# Cookbook:: vault-docker
# Recipe:: default
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

cookbook_file '/root/vault-entrypoint.sh' do
  mode '0755'
end

docker_image 'vault' do
  repo node['vault-docker']['repo']
  tag node['vault-docker']['tag']
end

docker_container 'vault' do
  cap_add 'IPC_LOCK'
  command 'server'
  entrypoint node['vault-docker']['entrypoint'] if node['vault-docker']['entrypoint']
  env docker_env(node['vault-docker']['config']) if node['vault-docker']['config']
  network_mode node['vault-docker']['network_mode']
  port node['vault-docker']['port']
  repo node['vault-docker']['repo']
  restart_policy 'always'
  sensitive node['vault-docker']['sensitive']
  tag node['vault-docker']['tag']
  volumes node['vault-docker']['volumes'] if node['vault-docker']['volumes']
end
