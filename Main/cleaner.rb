# Deletes the unnecessary files

def cleaner disp_mes = 0
	if !system("sudo rm -f *.ivs *.txt *.csv *.cap *.kismet *.netxml")
		abort("Error deleting trash files!")
	else
		if disp_mes == 1
			puts "\nUnnecessary files successfully deleted" 
		end
	end
end
