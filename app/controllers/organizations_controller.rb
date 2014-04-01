class OrganizationsController < ApplicationController
  def index
  	@organizations=Organization.all
  end

  def show
  	@organization=Organization.find(params[:id])
  	@user=current_user
  	@user_org=@user.organizations
  	@events=@organization.events
  end

  def edit
  end
end