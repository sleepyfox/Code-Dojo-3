#debug = true
fs = require 'fs'
helper = require './helper.js'

if debug? 
  filename = 'test.dat'
else 
  filename = 'weather.dat'

# read from file 'weather.dat'
lines = helper.readFile filename

# init spread to get lower than
INITIAL = {year: "1900", spread: "100"}

# remove everything but identifier (yyyy-dd) and temp spread
mappedLines = lines.map (line) -> 
  [dummy, year, month, max, min] = line.split /^\s+(\d{4})\s+(\d{1,2})\s+(\d{1,2}\.\d)\s+(\-?\d{1,2}\.\d).*$/
  # if regexp matches
  if max?
    {year: year + "-" + month, spread: helper.spread(max, min)}
  else
    {year:undefined, spread:undefined}

console.log i for i in mappedLines if debug? 

min = mappedLines.reduce((p, c) -> 
  if c.spread < p.spread
    c
  else
    p
,INITIAL)

# output results    
console.log "smallest spread=#{min.spread} in year #{min.year}"
