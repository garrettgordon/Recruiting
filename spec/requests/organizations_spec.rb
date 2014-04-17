require 'spec_helper'
require 'factory_girl_rails'

describe "Organizations" do 
	before(:each) do
    	DatabaseCleaner.clean_with(:truncation)
  	end

  	it "should get to organization page" do
  		@user1 = FactoryGirl.create(:user) 
  		sign_in()
  		visit "/organizations"
  		current_path.should == "/organizations"
  		#page.should have_content("Details")

  	end

  	it "display all organizations" do
  		@user1 = FactoryGirl.create(:user) 
  		@org1 = FactoryGirl.create(:organization)
  		sign_in()
  		visit "/organizations"
  		page.should have_content("Details")

  	end

  	it "searches for organizations" do
  		@user1 = FactoryGirl.create(:user) 

  		@org1 = FactoryGirl.build(:organization)
  		@org1.name = "abcd"
  		@org1.save

  		@org2 = FactoryGirl.build(:organization)
  		@org2.name = "abcde"
  		@org2.save

  		@org3 = FactoryGirl.create(:organization)

  		sign_in()
  		visit "/organizations"

  		fill_in "search", with: "abc"
  		click_button "Search"

  		page.should_not have_content("Name")
  		page.should have_content("abcde")

  	end



  	def sign_in()	
	  	visit "/"
	  	fill_in "user_session_username", with: "john"
	    
	  	fill_in "user_session_password", with: "pass"
	  	click_button "Login"
  	end

end
