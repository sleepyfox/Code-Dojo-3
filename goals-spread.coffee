debug = true

fs = require 'fs'
helper = require './helper.js'

# read from file football.dat
lines = helper.readFile 'football.dat'

# initialise smallest spread as large num e.g. 1000
minSpread = 1000.0

# for each line in file/team
for line in lines
  # read team name, goals for, goals against
  [dummy, team, goalsFor, goalsAgainst] = line.split /^\s+\d+.\s([\w_]+)\s+\d+\s+\d+\s+\d+\s+\d+\s+(\d+)\s+\-\s+(\d+)\s+\d+\s*$/
  # calculate spread
  if team?
    spread = helper.spread goalsFor, goalsAgainst

    # if spread smaller than smallest so far
    if spread < minSpread
      # record new smallest team and spread
      [minSpread, minTeam] = [spread, team]

# output results
console.log "smallest spread=#{minSpread} by team #{minTeam}"