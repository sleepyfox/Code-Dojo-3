helper = require './helper'

# initialise spread to a stupidly high value
INITIAL_SPREAD = 
  year: "1900"
  spread: "1000"

WEATHER_REGEXP = /^\s+(\d{4})\s+(\d{1,2})\s+(\d{1,2}\.\d)\s+(\-?\d{1,2}\.\d).*$/

lines = helper.readFile 'weather.dat'

# use map to remove everything but identifier (yyyy-dd) and temperature spread
mappedLines = lines.map (line) -> 
  [dummy, year, month, max, min] = line.split WEATHER_REGEXP
  # if regexp matches
  if max?
    year: year + "-" + month
    spread: helper.spread max, min
  else
    year: undefined
    spread: undefined

lowestSpread = (previous, current) -> 
  if current.spread < previous.spread then current else previous

minimum = mappedLines.reduce lowestSpread, INITIAL_SPREAD

console.log "smallest spread=#{minimum.spread} in year #{minimum.year}"