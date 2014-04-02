class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update]
  def index
  	@organizations=Organization.all
  end

  def show
  	@user=current_user
  	@user_org=@user.organizations
  	@events=@organization.events
  end

  def edit
  end

  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def set_organization
    @organization=Organization.find(params[:id])
  end

  def organization_params
      params.require(:organization).permit(:name, :location, :description, :link, )
  end
end