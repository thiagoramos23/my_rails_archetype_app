every 1.minute do 
	runner "Alert.verify_alerts", :output => 'log/alert.log'
end

set :output, {:error => 'log/error.log', :standard => 'log/cron.log'}