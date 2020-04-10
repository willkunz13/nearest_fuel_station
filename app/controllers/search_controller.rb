class SearchController < ApplicationController

	def index
		location = params[:location]
		binding.pry
		conn = Faraday.new(url: "https://developer.nrel.gov")
		response = conn.get("/api/alt-fuel-stations/v1/nearest.json?api_key=#{ENV["GOV_API_KEY"]}&location=#{location}")
		binding.pry
	end
end
