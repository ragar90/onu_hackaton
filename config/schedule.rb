set :output, "#{path}/log/cron.log"
every 1.minute do
  rake "tansfer_to_banks"
end