class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update]
  def index
  	@organizations=Organization.text_search(params[:search])
    # organizations=Organization.readySort(@organizations)
    # organizations=Organization.mergeSort(organizations)
    # @organizations=Organization.listConvert(organizations)
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

  def remove_attachment
    @org = Organization.find(params[:organization])
    @org.organization_picture.destroy
    @org[:organization_picture_file_name] = nil
    @org[:organization_picture_content_type] = nil
    @org[:organization_picture_file_size] = nil
    @org[:organization_picture_updated_at] = nil

    @org.save
    redirect_to :back
  end


private
  def set_organization
    @organization=Organization.find(params[:id])
  end

  def organization_params
      params.require(:organization).permit(:name, :location, :description, :link, :organization_picture)
  end
end