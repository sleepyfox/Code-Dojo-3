{Feature} = require 'vows-bdd'
assert = require 'assert'
hr = require '../HistoricalRecord'
wr = require '../Weather'

Feature("Testing the historical record provider", module)
  .scenario("Test the provider creation")
  .given "a new Historical Record object", ->
    @provider = new hr.HistoricalWeatherRecord 'resources/weather.dat'
    @callback()
  .then "the object should not be null", ->
    assert.isNotNull @provider
  .and "the line count should be zero", ->
    assert.equal @provider.lineCounter, 0
  .complete()

  .scenario("Test that the provider returns a weather object")
  .given "a new Historical Record object", ->
    @provider = new hr.HistoricalWeatherRecord 'resources/weather.dat'
    @callback()
  .then "when we call start we get 776 lines", ->
    lines = @provider.start()
    assert.equal lines, 776
  .and "next should return a Weather object", ->
    @weather = @provider.next()
    assert.instanceOf @weather, wr.Weather
  .and "the the year should be 1948", ->
    assert.equal @weather.year, 1948
  .and "the month should be 1", ->
    assert.equal @weather.month, 1
  .and "the maximum temperature should be 8.9", ->
    assert.equal @weather.tmax, 8.9
  .and "the minimum temperature should be 3.3", ->
    assert.equal @weather.tmin, 3.3
  .complete()

  .scenario("Test that the provider returns the correct next object")
  .given "the previous HistoricalWeatherRecord object", ->
    @provider = new hr.HistoricalWeatherRecord 'resources/weather.dat'
    throwAway = @provider.start()
    throwAway = @provider.next()
    @callback()
  .when "we call the next() method", ->
    @nextWeather = @provider.next()
    @callback()
  .then "we get back a Weather object", ->
    assert.instanceOf @nextWeather, wr.Weather
  .and "the the year should be 1948", ->
    assert.equal @nextWeather.year, 1948
  .and "the month should be 2", ->
    assert.equal @nextWeather.month, 2
  .and "the maximum temperature should be 7.9", ->
    assert.equal @nextWeather.tmax, 7.9
  .and "the minimum temperature should be 2.2", ->
    assert.equal @nextWeather.tmin, 2.2
  .complete()
  .finish(module)
