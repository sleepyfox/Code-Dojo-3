class Weather
  constructor: (@year, @month, @tmax, @tmin) ->

  spread: ->
    # assumes well-formed data
    @tmax - @tmin

exports.Weather = Weather
