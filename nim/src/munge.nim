import temp_spread
import sequtils

when isMainModule:
  echo("Finding smallest spread between highest and lowest monthly temperatures")
  let records = process_file("../heathrow-weather-data.txt").map(temp_reader)
  let temp_spreads = records.map(strings_to_temp).map(spread)

  echo "Occurs in ", temp_spreads.min()
