require 'spec_helper'
require 'factory_girl_rails'

describe "Jobs" do

	before(:each) do
		activate_authlogic
		@user = FactoryGirl.create(:user)
		@user_session = UserSession.create(@user)
		@job = FactoryGirl.create(:job)
		@org = FactoryGirl.create(:organization)
		@user.organizations << @org
		@job.skill_list = "django, python"
	end

	it "should get to job index pag" do
		sign_in()
		visit "/jobs"
		current_path.should == "/jobs"
	end

	it "should display the jobs and their details" do
		sign_in()
		visit "/jobs"
		page.should have_content("MyString")
	end

	it "details should link to job show page" do
		sign_in()
		visit "/jobs"
		page.should have_content("Details")
		click_link "Details"
		page.should have_content("MyString")
	end

	# it "job searching by tags" do
	# 	sign_in()
	# 	visit "/jobs"
	# 	fill_in "search",with: "django"
	# 	click_button "Search"
	# 	current_path.should == search_index_path(:search=>"django")
	# 	page.should have_content("MyString")
	# end

  def sign_in()	
  	visit "/"
  	fill_in "user_session_username", with: "john"
    
  	fill_in "user_session_password", with: "pass"
  	click_button "Login"
	end
end