require 'spec_helper'
require 'capybara/rspec'

feature "user can go to profile page" do 
	@user1 = User.create
	visit "users/1/"
	expect(page).to have_content("Logout")
end
