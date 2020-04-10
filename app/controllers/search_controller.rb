class SearchController < ApplicationController

	def index
		location = params[:location]
		conn = Faraday.new(url: "https://developer.nrel.gov")
		response = conn.get("/api/alt-fuel-stations/v1/nearest.json?api_key=#{ENV["GOV_API_KEY"]}&location=#{location}&limit=1")
		json = JSON.parse(response.body, symbolize_names: true)
		longlat = json[:fuel_stations].first[:latitude].to_s + ',' + json[:fuel_stations].first[:longitude].to_s
		
		conn = Faraday.new(url: "https://maps.googleapis.com")
		response = conn.get("/maps/api/directions/json?key=#{ENV["GOOGLE_API_KEY"]}&origin=#{location}&destination=#{longlat}")
		second_json = JSON.parse(response.body, symbolize_names: true) 
		
		name = json[:fuel_stations].first[:station_name]
		address = json[:fuel_stations].first[:street_address] + json[:fuel_stations].first[:city] + json[:fuel_stations].first[:state] + json[:fuel_stations].first[:zip]
		fuel = json[:fuel_stations].first[:fuel_type_code]
		times = json[:fuel_stations].first[:access_days_time]
	
		journey = second_json[:routes].first[:legs].first
		distance = journey[:steps].first[:distance][:text]
		duration = journey[:steps].first[:duration][:text]
		directions = journey[:steps].second[:html_instructions]
		
		@data = Hash.new
		@data[:name] = name
		@data[:address] = address
		@data[:fuel] = fuel
		@data[:times] = times
		@data[:distance] = distance
		@data[:duration] = duration
		@data[:directions] = directions 
		binding.pry
	end
end
