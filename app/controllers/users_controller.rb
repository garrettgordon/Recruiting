class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :disable_nav, only: [:landing, :newRecruiter, :verify]
  skip_before_filter :require_login, only: [:verify, :create, :newRecruiter, :finishRecruiter]
  # GET /users
  # GET /users.json
  def index
    if params[:search].nil?
      @users = User.all
    else
      @users = User.text_search(params[:search])
    end
  end

  def landing
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
    if current_user[:id] != @user[:id]
      redirect_to current_user
    end
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
      redirect_to '/#recruitersignup'
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
          redirect_to '/#recruitersignup'
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
      redirect_to '/#recruitersignup'
      return
    end
  end
  
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.recruiter= false

    password = user_params[:password]
    password_confirmation = user_params[:password_confirmation]
    
    if (password != password_confirmation) 
        flash[:notice] = "Password and confirmation do not match!" 
        redirect_to "/#signup"
        return
    end

    if (@user.username.length < 4)
      flash[:notice] = "Username must be at least 4 characters!" 
      redirect_to "/#signup"
      return
    end

    if (@user.password.length < 4 or @user.password_confirmation.length < 4)
      flash[:notice] = "Passwords must be at least 4 characters!" 
      redirect_to "/#signup"
      return
    end
    # Extract last 13 characters to check if "@berkeley.edu"
    email = @user.email[@user.email.length-13, @user.email.length]
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
        flash[:notice] = "We are sorry but this username is already taken or an account with this email has already been registered." 
        redirect_to "/#signup"
      end
    else
      flash[:notice] = "Must log in with Berkeley email address"
      redirect_to "/#signup"
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    logger.debug
    
    email = user_params[:email]
    email = email[email.length-13, email.length]
    regexMatch = /(@*\.berkeley.edu|@berkeley.edu)$/
    matchesFound = regexMatch.match(email)
    if (!matchesFound and current_user.recruiter==0)
      flash[:notice] = "Update failed: Must use a *.berkeley.edu email address!"
      redirect_to :back
      return
    end

    respond_to do |format|
      if @user.update(user_params)
        @user.skill_list = user_params[:skill_list]
        @user.course_list = user_params[:course_list]
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

  def changeAppStatus
    rdata=request.POST
    uid=rdata[:uid]
    jid=rdata[:jid]
    stat=rdata[:status]
    result=current_user.changeApplicantStatus(uid, jid, stat)
    if result==false
    end
  end

  def remove_attachment
    @user = User.find(params[:user])
    attachment_type = params[:attachment_type]
    if (attachment_type == "picture")
      @user.picture.destroy
      @user[:picture_file_name] = nil
      @user[:picture_content_type] = nil
      @user[:picture_file_size] = nil
      @user[:picture_updated_at] = nil
    elsif (attachment_type == "resume")
      @user.resume.destroy
      @user[:resume_file_name] = nil
      @user[:resume_content_type] = nil
      @user[:resume_file_size] = nil
      @user[:resume_updated_at] = nil
    end

    @user.save
    redirect_to :back
    return
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :gpa, :major, :minor, :name, :website, :graduating_year,
        :picture, :attachement_type, :resume, :skill_list, :course_list)
    end
end
