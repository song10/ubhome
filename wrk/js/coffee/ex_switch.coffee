go = (x) ->
	print "go #{x}"

bingoDay = "Sat"

for day in [ "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" ]
	do (day) ->
		switch day
			when "Mon" then go 'work'
			when "Tue" then go 'relax'
			when "Thu" then go 'iceFishing'
			when "Fri", "Sat"
				if day is bingoDay
					go 'bingo'
					go 'dancing'
				else
					go 'boring'
			when "Sun" then go 'church'
			else go 'work'
