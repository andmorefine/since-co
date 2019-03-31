# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

server 'xx.xxx.xxx.xxx', user: 'andmorefine', roles: %w(app db web)

set :ssh_options,   keys: %w(~/.ssh/id_rsa),
                    forward_agent: true,
                    auth_methods: %w(publickey)
