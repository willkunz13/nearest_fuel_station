class DataFacade
	def initiailze
		@location = location
	end

	def generate_station(@location)
		service = GovService.new
		station = Station.new(service.station) 
	end

	def generate_directions(@location, longlat)
		service = GoogleService.new(longlat)
		directions = Direction.new(service.directions)
	end
end
		
