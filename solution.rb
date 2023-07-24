require 'http'
require 'json'
gmap = ENV.fetch('GMAPS_KEY')
puts "Please enter a location"

location = gets.chomp

gmap_response = HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{gmap}")

parsed_gmap_response = JSON.parse(gmap_response)

pp parsed_gmap_response

loc_hash = parsed_gmap_response.fetch('results')


first_result_hash = loc_hash.at(0)

geometry_hash = first_result_hash.fetch("geometry")

location_hash = geometry_hash.fetch("location")

latitude = location_hash.fetch("lat")

longitude = location_hash.fetch("lng")

puts "Your coordinates are #{latitude}, #{longitude}."
