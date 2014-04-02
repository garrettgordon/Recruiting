require 'spec_helper'

describe OrganizationsController do
  include Authlogic::TestCase

  before(:each) do
    activate_authlogic
    @usr1 = FactoryGirl.create(:user)
    @user_session1 = UserSession.create(@usr1)
    @org1= FactoryGirl.create(:organization)
    @usr1.organizations << @org1
  end

  describe "Get Show" do
    it "successfully renders the show template" do
      get :show, id: @org1 
      response.should render_template :show
    end
  end

  describe "Get Edit" do
    it "successfully renders the edit template" do
      get :edit, id: @org1 
      response.should render_template :edit
    end
  end

  describe "Update" do
  	it "replaces info in the organization" do
  		put :update, {"organization" => {"name" => "Renamed", "description" => "Rescripted", "location" => "Relocated", "link" => "Relinked"}, "id" => @org1.id}
  		response.should redirect_to @org1
  		x = Organization.where(:name => "Renamed").first
  		expect(x.name).to eq("Renamed")
  		expect(x.description).to eq("Rescripted")
  		expect(x.location).to eq("Relocated")
  		expect(x.link).to eq("Relinked")
  	end
  end
end
