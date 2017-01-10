#!/usr/bin/env puma
# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum, this matches the default thread size of Active Record.
#

directory ENV['RAILS_APP_PATH']

# Min and Max threads per worker
threads ENV['MIN_THREADS'], ENV['MAX_THREADS']

rackup ENV['RAILS_APP_PATH'] + '/config.ru'
environment 'production'

# Daemonize the server into the background. Highly suggest that
# this be combined with "pidfile" and "stdout_redirect".
daemonize false

# Store the pid of the server in the file at "path".
pidfile ENV['RAILS_APP_PATH'] + '/tmp/pid/puma.pid'


# Use "path" as the file to store the server info state. This is
# used by "pumactl" to query and control the server.
state_path ENV['RAILS_APP_PATH'] + '/tmp/puma.state'

# Bind the server to "url". "tcp://", "unix://" and "ssl://" are the only
# accepted protocols.
#
# The default is "tcp://0.0.0.0:9292".

bind 'tcp://127.0.0.1:' + ENV['RAILS_APP_BIND_PORT']

# === Puma control rack application ===

# Start the puma control rack application on "url". This application can
# be communicated with to control the main server. Additionally, you can
# provide an authentication token, so all requests to the control server
# will need to include that token as a query parameter. This allows for
# simple authentication.
#
# Check out https://github.com/puma/puma/blob/master/lib/puma/app/status.rb
# to see what the app has available.

activate_control_app 'unix://' + ENV['RAILS_APP_PATH'] + '/run/pumactl.sock'
