require 'spec_helper'
require 'factory_girl_rails'

describe JobsController do
	#include AuthLogic::TestCase

	before(:each) do
		activate_authlogic
		@user = FactoryGirl.create(:user)
		@user_session = UserSession.create(@user)
		@job = FactoryGirl.create(:job)
		@org = FactoryGirl.create(:organization)
		@user.organizations << @org
	end

	describe "Get index" do
		it "successfully renders the index template" do
			get :index
			expect(response.status).to eq(200)
			expect(response).to render_template(:index)
		end

		it "@jobs returns list of jobs" do
			get :index, :search=>"MyString"
			expect(assigns(:jobs)).to eq(Job.text_search("MyString"))
		end
	end

	describe "get show" do
		it "successfully renders the show job template" do
			get :show, :id => @job.id
			expect(response.status).to eq(200)
			expect(response).to render_template(:show)
		end
	end

	describe "create job" do
		it "redirects to newly created job if success" do
			post :create, {"job"=>{"title"=>"test123", "description"=>"testing123", "skill_list"=>"django, rails"}}
			id = Job.find_by_title("test123").id
			expect(response).to redirect_to :action => :show, :id=>id
		end

		it "should show two jobs now" do
			post :create, {"job"=>{"title"=>"test123", "description"=>"testing123", "skill_list"=>"django, rails"}}
			expect(Job.all.size).to eq(2)
		end
	end
end
