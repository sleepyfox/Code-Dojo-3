helper = require './helper'

lines = helper.readFile 'weather.dat'

# initialise smallest spread as large number
minSpread = 1000.0
WEATHER_REGEXP = /^\s+(\d{4})\s+(\d{1,2})\s+(\d{1,2}\.\d)\s+(\-?\d{1,2}\.\d).*$/

for line in lines
  [dummy, year, month, max, min] = line.split WEATHER_REGEXP
  if year?
    spread = helper.spread max, min

    if spread < minSpread
      [minSpread, minYear, minMonth] = [spread, year, month]

console.log "smallest spread=#{minSpread} in year #{minYear} and month #{minMonth}"