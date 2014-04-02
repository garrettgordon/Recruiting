require 'spec_helper'
require 'factory_girl_rails'


describe "Users" do
  describe "GET /users" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get users_path
      response.status.should be(200)
    end
  end

  describe "has profile page" do
  	it "has logout on profile page" do
  		sign_in()
  		current_path.should == "/home"
  	end

  end
  def sign_in()
  	@user1 = FactoryGirl.create(:user)
  	visit "/"
  	fill_in "user_session_username", with: "john"
    
  	fill_in "user_session_password", with: "pass"
  	click_button "Login"
  end


end
