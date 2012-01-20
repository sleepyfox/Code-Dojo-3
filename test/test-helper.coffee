vows = require 'vows'
assert = require 'assert' 
helper = require '../helper.js'

vows
  .describe('helper')
  .addBatch 
    'when reading a file': 
      topic: -> 
        helper.readFile 'test.txt'
      'we get a valid file': (topic) ->
        assert.equal topic.length, 3 # including last blank line
      'we get the right first line': (topic) ->
        assert.equal topic[0], 'Now is the time for all good men'

  .addBatch
    'when finding the spread of 10 and 6':
      topic: -> 
        helper.spread 10, 6
      'we get 4': (topic) ->
        assert.equal topic, 4

    'when finding the spread of 6 and 10':
      topic: -> 
        helper.spread 6, 10
      'we get 4': (topic) ->
        assert.equal topic, 4
  
    'when finding the spread of 6 and -10':
      topic: -> 
        helper.spread 6, -10
      'we get 4': (topic) ->
        assert.equal topic, 16

    'when finding the spread of -10 and 6':
      topic: -> 
        helper.spread -10, 6
      'we get 4': (topic) ->
        assert.equal topic, 16

  .export(module)  