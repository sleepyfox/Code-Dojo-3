infinite_range = () ->
  count = 0
  while true
    count = count + 1
    yield count
  1

generator = infinite_range()
console.log generator.next()
console.log generator.next()
