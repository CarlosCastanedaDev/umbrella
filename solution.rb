require 'http'
require 'json'
# API Keys
gmap = ENV.fetch('GMAPS_KEY')
pirate = ENV.fetch('PIRATE_WEATHER_KEY')

puts "Please enter your location"

location = gets.chomp

puts "Getting the weather for #{location.capitalize}..."

# Get Location
gmap_response = HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{gmap}")

parsed_gmap_response = JSON.parse(gmap_response)

loc_hash = parsed_gmap_response.fetch('results')

first_result_hash = loc_hash.at(0)

geometry_hash = first_result_hash.fetch("geometry")

location_hash = geometry_hash.fetch("location")

latitude = location_hash.fetch("lat")

longitude = location_hash.fetch("lng")

# Get Weather
pirate_response = HTTP.get("https://api.pirateweather.net/forecast/#{pirate}/#{latitude},#{longitude}")

parsed_weather_response = JSON.parse(pirate_response)

weather_hash = parsed_weather_response.fetch('currently') 

hourly_weather = parsed_weather_response.fetch('hourly')
hourly_weather_data = hourly_weather.fetch('data')


puts "The current temp is #{weather_hash['temperature'].floor()}°F."
puts "The weather for the next hour is #{hourly_weather['summary'].downcase}."
