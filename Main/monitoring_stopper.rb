#Monitoring Stopper

def monitoring_stopper interfaces = Array.new

	interfaces.each do |el|
		`sudo airmon-ng stop #{el} > mon_stopper.txt`
	end

end

