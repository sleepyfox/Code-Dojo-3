{Feature} = require 'vows-bdd'
assert = require 'assert'
wr = require '../Weather'

Feature("Testing the weather", module)
  .scenario("Testing weather object creation")
  .given "an empty weather object", ->
    @weather = new wr.Weather
    @callback()
  .then "we shouldn't be able to read the year", ->
    assert.isUndefined @weather.year
  .complete()

  .scenario("Test weather object creation")
  .given "a new weather object", ->
    # setup condition
    @weather = new wr.Weather 1998, 1, 4.0, 1.0 
    @callback() 
  .then "the year should be 1998", ->
    # make assertions about result
    assert.equal @weather.year, 1998
  .and "the month should be 1", ->
    assert.equal @weather.month, 1
  .and "the maximum temperature should be 4.0", ->
    assert.equal @weather.tmax, 4
  .and "the minimum temperature should be 1.0", ->
    assert.equal @weather.tmin, 1
  .and "the spread should be 3.0", ->
    assert.equal @weather.spread(), 3
  .complete()
  .finish(module)