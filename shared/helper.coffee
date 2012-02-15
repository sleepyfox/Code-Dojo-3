fs = require 'fs'

exports.spread = (first, second) ->
  [num1, num2] = [Number(first), Number(second)]
  if num1 > num2 
    num1 - num2
  else
    num2 - num1
  
exports.readFile = (filename) ->
  try 
    data = fs.readFileSync filename, 'ascii'
  catch err
    console.error "There was an error opening the file: #{filename}"
    console.log err

  # split the data into lines
  lines = data.split '\n'
 