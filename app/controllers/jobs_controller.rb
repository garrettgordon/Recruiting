class JobsController < ApplicationController
	before_action :set_job, only: [:show, :edit, :update, :destroy, :addUser, :removeUser]
  # GET /events
  # GET /events.json
  def index
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end


  # GET /events/new
  def new
    @job = Job.new()
    # @event.type = params[:event_type]
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    logger.debug(params.inspect)
    @event = Event.new(event_params)
    dateTimeObj = DateTime.new(params[:date][:year].to_i,params[:date][:month].to_i,params[:date][:day].to_i,params[:date][:hour].to_i,params[:date][:minute].to_i)
    @event[:date] = dateTimeObj
    if (params[:speakers] != "")
      @event[:event_type] = "speaker_panel"
    end
    logger.debug @event.inspect
    respond_to do |format|
      if @event.save
        if current_user.recruiter
          @event.users << current_user
          @event.organizations << (current_user.organizations.first)
        end
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update

    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
  	if current_user.organizations.first != @org
  		redirect_to "/"
  		return
  	end
    @job.destroy
    respond_to do |format|
      format.html { redirect_to  @org}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
      @org = @job.organization
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :description)
    end
end
