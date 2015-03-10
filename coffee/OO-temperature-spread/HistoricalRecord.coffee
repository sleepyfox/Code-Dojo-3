helper = require "../shared/helper"
wr = require "./Weather"

WEATHER_REGEXP = /^\s+(\d{4})\s+(\d{1,2})\s+(\d{1,2}\.\d)\s+(\-?\d{1,2}\.\d).*$/

class HistoricalWeatherRecord

  constructor: (@filename) ->
    @lineCounter = 0    
   
  start: -> 
    # open a file for reading
    @array = helper.readFile @filename
    @array.length

  next: ->
    # read the next line in the file and return a Weather object
    if @lineCounter is @array.length - 1
      null # when we reach end of array
    else
      until year? # skip non-compliant lines
        [dummy, year, month, max, min] = @array[@lineCounter++].split WEATHER_REGEXP
      weather = new wr.Weather year, month, max, min

exports.HistoricalWeatherRecord = HistoricalWeatherRecord
