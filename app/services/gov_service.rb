class GovService
	
	def initialize(location)
		@location = location
	end

	def station
		get_json(@location)[:fuel_stations].first
	end

	private

	def get_json(location)
		response = conn(location)
		JSON.parse(response.body, symbolize_names: true)
	end

	def conn(location)
		connect = Faraday.new(url: "https://developer.nrel.gov") 
    response = connect.get("/api/alt-fuel-stations/v1/nearest.json?api_key=#{ENV["GOV_API_KEY"]}&location=#{location}&limit=1")	
	end
end
		
		
