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

  		fill_in "search", with: "abcd"
  		click_button "Search"

  		page.should_not have_content("Name")
  		page.should have_content("abcd")

  	end

    it "has job listings" do
      @user1 = FactoryGirl.create(:user) 
      @org1 = FactoryGirl.build(:organization)
      @org1.name = "abcd"
      @org1.save
      @job1= FactoryGirl.build(:job)
      @job1.organization=@org1
      @job2= FactoryGirl.build(:job)
      @job2.organization=@org1
      @job1.save
      @job2.save
      @user1.save
      @org1.save
      sign_in()
      visit "/organizations/1"
      page.should have_content("Job Listings:")
      page.should have_content("MyString")
    end

    it "has add jobs link if recruiter" do
      @user1 = FactoryGirl.create(:user, :username => "Paul", :password => "pass", :recruiter => true)
      @user2 = FactoryGirl.create(:user, :username => "Kyle", :email => "blue@berkeley.edu", :password => "pass", :recruiter => false) 
      @org1 = FactoryGirl.build(:organization)
      @user1.organizations << @org1
      @org1.name = "abcd"
      @org1.save
      @user1.save
      @user2.save
      visit "/"
      fill_in "user_session_username", with: "Paul"
      fill_in "user_session_password", with: "pass"
      click_button "Login"
      visit "/organizations/1"
      page.should have_content("Add Job")
      click_link "Add Job"
      current_path.should == '/jobs/new'
      visit "/"
      click_link "Logout"

      visit "/"
      fill_in "user_session_username", with: "Kyle"
      fill_in "user_session_password", with: "pass"
      click_button "Login"
      visit "/organizations/1"
      page.should_not have_content("Add Job")

    end



  	def sign_in()	
	  	visit "/"
	  	fill_in "user_session_username", with: "john"
	    
	  	fill_in "user_session_password", with: "pass"
	  	click_button "Login"
  	end

end
