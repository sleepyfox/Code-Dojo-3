import temp_spread
import sequtils

when isMainModule:
  echo("Finding smallest spread between highest and lowest monthly temperatures")
  let records = process_file("../heathrow-weather-data.txt").map(temp_reader)
  let temp_spreads = records.map(strings_to_temp).map(spread)

  # Could we replace this with a fold?
  var min_spread = temp_spreads[0]
  for i in temp_spreads:
    if i.temp_spread < min_spread.temp_spread:
      min_spread = i

  echo "Occurs in ", min_spread
