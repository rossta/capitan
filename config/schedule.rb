# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
# */3 * * * * /bin/bash -l -c 'cd /web/capitan && source .powenv && RAILS_ENV=development bundle exec rake sync --silent >> /web/capitan/log/cron.log 2>&1'

# Example:
#
set :output, "/web/capitan/log/cron.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

every 1.minutes do
  rake "sync"
end

# Learn more: http://github.com/javan/whenever
