package 'curl'
package 'unzip'

execute 'curl -f -o /root/vault.zip https://releases.hashicorp.com/vault/0.7.2/vault_0.7.2_linux_amd64.zip' do
  creates '/root/vault.zip'
end

execute 'unzip /root/vault.zip -d /usr/bin' do
  creates '/usr/bin/vault'
end
