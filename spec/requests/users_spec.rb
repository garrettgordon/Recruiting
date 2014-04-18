require 'spec_helper'
require 'factory_girl_rails'


describe "Users" do
  before(:each) do
    DatabaseCleaner.clean_with(:truncation)
  end
  describe "logon" do
  	it "logs in with succesful login" do
  		@user1 = FactoryGirl.create(:user)
  		sign_in()
  		current_path.should == "/home"
  	end

  	it "doesn't login with incorrect parameters" do
  		@user1 = FactoryGirl.create(:user)
	  	visit "/"
	  	fill_in "user_session_username", with: "john"
	  	fill_in "user_session_password", with: "pass1"
	  	click_button "Login"
	  	current_path.should == "/"
  	end

  end

  describe "home page" do
  	it "goes to profile page" do
  		@user1 = FactoryGirl.create(:user)
  		sign_in()
  		click_link(@user1.username)
  		current_path.should == "/users/1"
  	end

  	it "logs out" do
  		@user1 = FactoryGirl.create(:user)
  		sign_in()
  		click_link("Logout")
  		current_path.should == "/"
  	end

  	it "goes to event" do
  		@user1 = FactoryGirl.create(:user)
  		@event1 = FactoryGirl.create(:event)
  		sign_in()
  		click_link("Details")
  		current_path.should == "/events/1"

  	end

  	it "follows event" do
  		@user1 = FactoryGirl.create(:user)
  		@event1 = FactoryGirl.create(:event)
  		sign_in()
  		click_link("Details")
  		click_link("Follow")
  		current_path.should == '/events/1'
  		@user1.events.first.should == @event1

  	end

  end

  describe "recruiter logon" do
  	it "logs in with succesful login" do
  		@user1 = FactoryGirl.build(:user)
  		@user1.recruiter = true
  		@org1 = Organization.new(name:"s")
  		@user1.organizations << @org1
  		@user1.save!

  		sign_in()
  		current_path.should == "/users/1"
  	end
  end

  describe "adding tags" do
    it "can add tags from the edit page" do
      @user1 = FactoryGirl.build(:user)
      @user1.save
      sign_in()
      click_link "john"
      page.should have_content("Edit")
      click_link "Edit"
      fill_in "user_skill_list", with: "work, fun"
      click_button "Update"
      @user1.save
      @user1.skill_list.include?("work").should== true
      @user1.skill_list.include?("fun").should == true
    end
  end

  describe "applying to job" do
    it "users can apply" do
      @user1 = FactoryGirl.build(:user)
      @user1.save
      @organization= FactoryGirl.build(:organization)
      @job = FactoryGirl.build(:job)
      @job.organization=@organization
      @job.save
      @organization.save
      sign_in()
      visit "/organizations/1"
      click_link "MyString"
      current_path.should == "/jobs/1"
      page.should have_content("Apply")
      click_link "Apply"
      @user1.jobs.include?(@job).should== true
      visit "/jobs/1"
      page.should have_content("Cancel Application")
    end
  end

  def sign_in()	
  	visit "/"
  	fill_in "user_session_username", with: "john"
    
  	fill_in "user_session_password", with: "pass"
  	click_button "Login"
  end


end
