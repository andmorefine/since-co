threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
threads threads_count, threads_count

port        ENV.fetch('PORT') { 3000 }

environment ENV.fetch('RAILS_ENV') { 'development' }

# workers ENV.fetch("WEB_CONCURRENCY") { 2 }
# bind "unix://#{Rails.root}/tmp/sockets/puma.sock"

# pidfile "/var/run/since-co/since-co.pid"
# bind "unix:///var/run/since-co/since-co.sock"

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
