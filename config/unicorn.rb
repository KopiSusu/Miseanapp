# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "~/projects/cookbook"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "~/projects/cookbook/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "~/projects/cookbook/log/unicorn.log"
stdout_path "~/projects/cookbook/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.[cookbook].sock"
listen "/tmp/unicorn.cookbook.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30