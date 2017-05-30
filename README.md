# vault-docker

Cookbook to setup vault using docker.

## Supported Platforms

Tested And Validated On
- Ubuntu 16.04

## Usage

### recipe[vault-docker::default]

Include `vault-docker` in your run_list.

```json
{
  "run_list": [
    "recipe[vault-docker::default]"
  ]
}
```

### Attributes

Attribute | Description | Type | Default
----------|-------------|------|--------
`node['vault-docker']['config']` | Hash of configuration environment variables for Consul.  Primary way to configure how vault-docker starts. See [vault-docker docker image](https://hub.docker.com/_/vault/) and [vault configuration file docs](vault configuration) for more information.  See [`.kitchen.yml`](.kitchen.yml) for examples of using this to drive behavior. | Hash | `nil`
`node['vault-docker']['entrypoint']` | Start the vault container with your own entrypoint.  Must be added as volume to container. | String | `nil`
`node['vault-docker']['port']` | Port(s) to expose from docker container. See [docker cookbook](https://github.com/chef-cookbooks/docker#properties-7) for more info. | String | `'8200:8200'`
`node['vault-docker']['repo']` | The docker repo for the image to use | String | `'vault'`
`node['vault-docker']['tag']` | The docker tag for the image to use | String | `'0.8.3'`
`node['vault-docker']['sensitive']` | Whether to consider container resource sensitive or not | Boolean | `false`
`node['vault-docker']['volumes']` | Volumes to have added to your container | Array | `nil`

## Testing

* Linting - Cookstyle and Foodcritic
* Spec - ChefSpec
* Integration - Test Kitchen

Testing requires [ChefDK](https://downloads.chef.io/chef-dk/) be installed using it's native gems.

```
foodcritic -f any -X spec .
cookstyle
rspec --color --format progress
```

If you run into issues testing please first remove any additional gems you may
have installed into your ChefDK environment.  Extra gems can be found and removed
at `~/.chefdk/gem`.

## License and Authors

Author:: Jacob McCann (<jacob.mccann2@target.com>)

```text
Copyright:: 2017, Jacob McCann

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

```
