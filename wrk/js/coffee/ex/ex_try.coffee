allHellBreaksLoose = ->
	print "allHellBreaksLoose"

catsAndDogsLivingTogether = ->
	throw "xxx: catsAndDogsLivingTogether"

cleanUp = ->
	print "cleanUp"

try
	allHellBreaksLoose()
	catsAndDogsLivingTogether()
catch error
	print error
finally
	cleanUp()
