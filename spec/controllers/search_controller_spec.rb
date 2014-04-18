require 'spec_helper'
require 'factory_girl_rails'

describe SearchController do
	#include AuthLogic::TestCase

	before(:each) do
		activate_authlogic
		@user = FactoryGirl.create(:user)
		@user_session = UserSession.create(@user)
		@job = FactoryGirl.create(:job)
		@org = FactoryGirl.create(:organization)
		@user.skill_list = "django, rails"
		@job.skill_list = "django, python"
	end

	describe "get index" do
		it "successfully renders the index template" do
			get :index
			expect(response.status).to eq(200)
			expect(response).to render_template(:index)
		end

		it "returns job if passed MyString" do
			get :index, :search=>"MyString"
			expect(assigns(:jobs)).to eq(Job.text_search("MyString"))
		end

		it "returns job if searching python" do
			get :index, :search=>"python"
			expect(assigns(:jobs)).to eq(Job.text_search("python"))
		end

		it "returns job and user for input django" do
			get :index, :search => "python"
			expect(assigns(:jobs)).to eq(Job.text_search("python"))
			expect(assigns(:users)).to eq(User.text_search("python"))
		end
	end
end
