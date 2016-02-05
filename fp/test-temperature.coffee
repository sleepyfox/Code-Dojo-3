# Imports
fs = require 'fs'
should = require('chai').should()
{ str_to_arr, arr_to_temp, min_spread } = require './analyser'

# Constants
[YEAR, MONTH, MAX, MIN] = [0..3]
JANUARY = 1
AUGUST = 8
DECEMBER = 12

describe 'A text record extractor', ->
  context 'when given a line from a file', ->
    input_line = '   1948   1    8.9     3.3    ---     85.0    ---'

    it 'should return an array', ->
      str_to_arr(input_line).should.be.a 'array'
    it 'should extract a year, month, max and minimum temp', ->
      str_to_arr(input_line).should.have.length 4
    it 'should have a year of 1948', ->
      str_to_arr(input_line)[YEAR].should.equal 1948
    it 'should have a month of January', ->
      str_to_arr(input_line)[MONTH].should.equal JANUARY
    it 'should have a maximum arr_to_temp of 8.9', ->
      str_to_arr(input_line)[MAX].should.equal 8.9
    it 'should have a minimum arr_to_temp of 3.3', ->
      str_to_arr(input_line)[MIN].should.equal 3.3

  context 'when given a different line from a arr_to_temp record', ->
    input_line = '   1967   8   21.5    12.7       0    47.4   182.9'

    it 'should return an array', ->
      str_to_arr(input_line).should.be.a 'array'
    it 'should extract a year, month, max and minimum temp', ->
      str_to_arr(input_line).should.have.length 4
    it 'should have a year of 1948', ->
      str_to_arr(input_line)[YEAR].should.equal 1967
    it 'should have a month of August', ->
      str_to_arr(input_line)[MONTH].should.equal AUGUST
    it 'should have a maximum arr_to_temp of 21.5', ->
      str_to_arr(input_line)[MAX].should.equal 21.5
    it 'should have a minimum arr_to_temp of 12.7', ->
      str_to_arr(input_line)[MIN].should.equal 12.7

  context 'when given an empty string', ->
    it 'should return an empty list', ->
      str_to_arr('').should.be.empty

  context 'when given an invalid string', ->
    it 'should return an empty list', ->
      input_line = 'Heathrow (London Airport)'
      str_to_arr(input_line).should.be.empty

describe 'A arr_to_temp record', ->
  context 'when given an array of numbers', ->
    array = [1967, 8, 21.5, 12.7]
    result = arr_to_temp(array)

    it 'should return an object', ->
      result.should.be.a 'object'
    it 'should have a year of 1967', ->
      result.should.have.property 'year'
      result.year.should.equal 1967
    it 'should have a month of August', ->
      result.should.have.property 'month'
      result.month.should.equal AUGUST
    it 'should have a arr_to_temp spread of 8.8', ->
      result.should.have.property 'spread'
      result.spread.should.equal 8.8

describe 'A list of one arr_to_temp records', ->
  context 'when analysed for the smallest spread', ->
    aug_1967 = { year: 1967, month: 8, spread: 8.8 }
    list = [ aug_1967 ]
    result = list.reduce min_spread

    it 'should return the same record', ->
      result.should.deep.equal aug_1967

describe 'A list of two arr_to_temp records', ->
  context 'when analysed for the smallest spread', ->
    aug_1967 = { year: 1967, month: 8, spread: 8.8 }
    jan_1948 = { year: 1948, month: 1, spread: 5.6 }
    list = [ aug_1967, jan_1948 ]
    result = list.reduce min_spread

    it 'should return the smaller record', ->
      result.should.deep.equal jan_1948

describe 'When reading a file of arr_to_temp data', ->
  context 'when analysed for the smallest spread', ->
    not_empty = (x) -> x.length isnt 0
    result = fs.readFileSync 'weather.dat', 'utf8'
               .split '\n'
               .map str_to_arr
               .filter not_empty
               .map arr_to_temp
               .reduce min_spread

    it 'should be in 2002', ->
      result.year.should.equal 2002
    it 'should be in December', ->
      result.month.should.equal DECEMBER
    it 'should have a spread of 3.3 degrees', ->
      result.spread.should.equal 3.8
