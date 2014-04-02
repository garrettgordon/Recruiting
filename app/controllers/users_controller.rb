class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destro]
  before_filter :disable_nav, only: [:index, :newRecruiter, :verify]
  skip_before_filter :require_login, only: [:verify, :create, :newRecruiter, :finishRecruiter]
  # GET /users
  # GET /users.json
  def index
    @user = User.new
    @user_session = UserSession.new
    if not current_user.nil?
      if current_user.recruiter
        redirect_to current_user
      else
        redirect_to '/home'
      end
    end
  end

  def verify
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @events= @user.events
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def newRecruiter
    @user = User.new
  end

  def finishRecruiter
    @user=User.new(user_params)
    data=request.POST
    choice=data[:org_choice]
    org=data[:organization]
    if org.nil? or org == ""
      redirect_to '/'
      return
    end
    @organ=Organization.new()
    @user.recruiter=true
    if @user.valid?
      if choice == "join"
        @organ=Organization.find_by name: org
        if not @organ.nil?
          @user.save
          @user.organizations << @organ
          @user.deliver_verification_instructions!
          redirect_to '/verify'
          return
        end
      end
      if choice == "create"
        @organ=Organization.find_by name: org
        if not @organ.nil?
          redirect_to '/'
          return
        else
          @organ=Organization.new()
          @organ.name=org
          if @organ.save
            @user.save
            @user.organizations << @organ
            @user.deliver_verification_instructions!  
            redirect_to '/verify'
            return
          end
        end
      end
    else
      redirect_to '/'
      return
    end
  end
  
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.recruiter= false
    # Extract last 13 characters to check if "@berkeley.edu"
    email = @user.email[@user.email.length-13, @user.email.length]
    # regexMatch = /@.*.berkeley.edu$/
    regexMatch = /(@*\.berkeley.edu|@berkeley.edu)$/
    matchesFound = regexMatch.match(email)
    if matchesFound
      if @user.save
        #UserMailer.registration_confirmation(@user).deliver
        #flash[:notice] = "SUCCESS!"
        @user.deliver_verification_instructions!
        # format.html { redirect_to @user, notice: 'User was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @user }
        redirect_to "/verify"
      else
        # format.html { render action: 'new' }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
        flash[:notice] = "All fields other than email must be at least 4 characters and contain valid characters." 
        redirect_to "/"
      end
    else
      flash[:notice] = "Must log in with Berkeley email address"
      redirect_to "/"
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :gpa, :major, :minor, :name, :website, :graduating_year)
    end
end
