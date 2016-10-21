env :PATH, ENV["PATH"]
set :environment, "development"
set :output, "/home/thaodtd/log.log"

every "0 0 1 * *" do
  MonthlyWorker.perform_async MonthlyWorker::MONTHLY
end

every "0 0 * * *" do
  DailyWorker.perform_async DailyWorker::DAILY
end
