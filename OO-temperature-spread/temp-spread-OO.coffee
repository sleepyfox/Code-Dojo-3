hr = require "./HistoricalRecord"
helper = require "../shared/helper"

provider = new hr.HistoricalWeatherRecord "../resources/weather.dat"
provider.start()

until (weather = provider.next()) is null
  unless smallestWeatherRecord? then smallestWeatherRecord = weather
  if weather.spread() < smallestWeatherRecord.spread() 
    smallestWeatherRecord = weather
  
console.log "The smallest spread occured in #{smallestWeatherRecord.year}, month #{smallestWeatherRecord.month} and was #{smallestWeatherRecord.spread()}"
