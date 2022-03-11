# Imports
fs = require 'fs'
should = require('chai').should()
{ parse_footie_string, footie_record, min } = require './analyser'

# Constants
[YEAR, MONTH, MAX, MIN] = [0..3]
JANUARY = 1
AUGUST = 8
DECEMBER = 12

describe 'When reading a file of football record data', ->
  context 'when analysed for the smallest spread', ->
    not_empty = (x) -> x.length isnt 0
    result = fs.readFileSync 'football.dat', 'utf8'
               .split '\n'
               .map parse_footie_string
               .filter not_empty
               .map footie_record
               .reduce min 'spread'

    it 'should be ?', ->
      result.team.should.equal ''
    it 'should have a spread of ? goals', ->
      result.spread.should.equal 3
