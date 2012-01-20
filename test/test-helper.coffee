vows = require 'vows'
assert = require 'assert' 
helper = require '../helper'

vows
  .describe('Given we want to find a minimum temperature spread')
  .addBatch 
    'when reading a file': 
      topic: -> 
        helper.readFile 'test.txt'
      'then we get a valid file': (topic) ->
        assert.equal topic.length, 3 # including last blank line
      'then we get the right first line': (topic) ->
        assert.equal topic[0], 'Now is the time for all good men'

    'when finding the spread of 10 and 6':
      topic: -> 
        helper.spread 10, 6
      'then we get 4': (topic) ->
        assert.equal topic, 4

    'when finding the spread of 6 and 10':
      topic: -> 
        helper.spread 6, 10
      'then we get 4': (topic) ->
        assert.equal topic, 4
  
    'when finding the spread of 6 and -10':
      topic: -> 
        helper.spread 6, -10
      'then we get 4': (topic) ->
        assert.equal topic, 16

    'when finding the spread of -10 and 6':
      topic: -> 
        helper.spread -10, 6
      'then we get 4': (topic) ->
        assert.equal topic, 16

  .export(module)  