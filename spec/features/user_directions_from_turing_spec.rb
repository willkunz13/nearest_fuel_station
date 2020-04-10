require 'rails_helper'

describe "user", :vcr do
  scenario "directions from turing" do
    visit '/'
		click_on "Find Nearest Station"
		expect(current_path).to eq("/search")
		expect(page).to have_content("Name")
		expect(page).to have_content("Fuel Type")
		expect(page).to have_content("Address")
		expect(page).to have_content("Access Times")
		expect(page).to have_content("Distance: 0.1 miles")
		expect(page).to have_content("Travel Time: 1 min")
		expect(page).to have_content("Turn left onto Lawrence St\nDestination will be on the left")
  end
end
