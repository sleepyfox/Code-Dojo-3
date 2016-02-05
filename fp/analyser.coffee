str_to_arr = (string) ->
  FIRST = 1
  LAST = 5
  WEATHER_REGEXP = /// ^
    \s+ (\d{4})           # Year
    \s+ (\d{1,2})         # Month
    \s+ (\d{1,2}\.\d)     # Max temp, 1 decimal place
    \s+ (\-?\d{1,2}\.\d)  # Min temp, 1 decimal place, maybe negative
    .* $ ///

  str_to_num = (x) -> +x

  string
  .split WEATHER_REGEXP
  .slice FIRST, LAST
  .map str_to_num

arr_to_temp = (weather_record) ->
  [YEAR, MONTH, MAX, MIN] = [0..3] # Data record indices
  year: weather_record[YEAR]
  month: weather_record[MONTH]
  spread: Math.abs(weather_record[MAX] - weather_record[MIN])

min_spread = (a, b) ->
  if a.spread < b.spread
    a
  else
    b

module.exports =
  str_to_arr: str_to_arr
  arr_to_temp: arr_to_temp
  min_spread: min_spread
