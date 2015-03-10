helper = require '../shared/helper'

lines = helper.readFile '../resources/football.dat'

# initialise smallest spread as large number
minSpread = 1000.0
FOOTBALL_REGEXP = /^\s+\d+.\s([\w_]+)\s+\d+\s+\d+\s+\d+\s+\d+\s+(\d+)\s+\-\s+(\d+)\s+\d+\s*$/

for line in lines
  [dummy, team, goalsFor, goalsAgainst] = line.split FOOTBALL_REGEXP
  if team?
    spread = helper.spread goalsFor, goalsAgainst

    if spread < minSpread
      [minSpread, minTeam] = [spread, team]

console.log "smallest spread=#{minSpread} by team #{minTeam}"