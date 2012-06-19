
theBait   = 1000
theSwitch = 0

[theBait, theSwitch] = [theSwitch, theBait]

weatherReport = (location) ->
  # Make an Ajax request to fetch the weather...
  [location, 72, "Mostly Sunny"]

[city, temp, forecast] = weatherReport "Berkeley, CA"

print theBait
print theSwitch
print 'city="#{city}", temp="#{temp}", forecast="#{forecast}"'
print "city=\"#{city}\", temp=\"#{temp}\", forecast=\"#{forecast}\""
print """city="#{city}", temp="#{temp}", forecast="#{forecast}" """

futurists =
  sculptor: "Umberto Boccioni"
  painter:  "Vladimir Burliuk"
  poet:
    name:   "F.T. Marinetti"
    address: [
      "Via Roma 42R"
      "Bellagio, Italy 22021"
    ]

{poet: {name, address: [street, city]}} = futurists
print """name="#{name}", street="#{street}", city="#{city}" """
