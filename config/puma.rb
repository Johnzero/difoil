threads 6,32
workers 2
environment 'production'
pidfile '/tmp/difoil.pid'
state_path '/tmp/difoil.state'
daemonize true
bind 'unix:///var/run/difoil.sock'
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
