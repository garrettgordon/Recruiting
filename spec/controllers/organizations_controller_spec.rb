require 'spec_helper'

describe OrganizationsController do

  let(:valid_attributes) { { "username" => "MyString", "email" => "foo@berkeley.edu", "password" => "nine", "password_confirmation" => "nine" } }
  let(:organization_attributes) { {"name" => "Foo"} }

  describe "create organization" do
    it "creates a valid organization" do
      user = User.create! valid_attributes
      
      post :finishRecruiter, {:user => user, :org_choice => "create"}
    end
  end


end
