require 'spec_helper'
require 'factory_girl_rails'
#:username, :email, :password, :password_confirmation
describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "can be created" do
		stuff = {username: "eric", email: "eoneill@berkeley.edu", password: "pass", password_confirmation: "pass"}

		@user1 = User.new(stuff)
		@user1.save.should == true
  end

  it "can be retrieved" do
  	stuff = {username: "eric", email: "eoneill@berkeley.edu", password: "pass", password_confirmation: "pass"}
  	@user1 = User.new(stuff)
  	@user1.save

  	User.find_by_username("eric").should == @user1
  end


  it "has many events" do
  	@event1 = FactoryGirl.create(:event)
  	@event2 = FactoryGirl.create(:event, :id=>2)

  	stuff = {username: "eric", email: "eoneill@berkeley.edu", password: "pass", password_confirmation: "pass"}
  	@user1 = User.new(stuff)
  	@user1.save

    @event1.users << @user1
    @event2.users << @user1

  	@user1.events.first.should == @event1
  	@user1.events.last.should == @event2
  end

  it "has a perishable token" do
    stuff = {username: "eric", email: "eoneill@berkeley.edu", password: "pass", password_confirmation: "pass"}
    @user = User.new(stuff)
    @user.save
    @user.perishable_token.should_not be_empty
  end

  it "should default verified to false then true when verify! is called" do
    stuff = {username: "eric", email: "eoneill@berkeley.edu", password: "pass", password_confirmation: "pass"}
    @user = User.new(stuff)
    @user.save
    @user.verified.should == false
    @user.verify!
    @user.verified.should == true
  end

  it "can apply to jobs" do
    stuff = {username: "eric", email: "eoneill@berkeley.edu", password: "pass", password_confirmation: "pass"}
    @user = User.new(stuff)
    @job=FactoryGirl.build(:job)
    @job1=FactoryGirl.build(:job, :id=> 2 )
    @user.save.should==true
    @job.save.should==true
    @job1.save.should==true
    @user.jobs << @job
    @user.jobs << @job1
    @user.jobs.nil?.should==false
    @user.jobs.length.should==2
    jas=Jobapp.all
    jas.nil?.should==false
    jas.length.should==2
    jas=Jobapp.where(:user_id => @user[:id])
    jas.nil?.should==false
    jas.length.should==2
    @job2=FactoryGirl.build(:job, :id=> 3 )
    @job2.save
    boo=@user.applyToJob(@job2[:id])
    boo.should==true
  end

  it "can change an applicants status" do
    stuff = {username: "eric", email: "eoneill@berkeley.edu", password: "pass", password_confirmation: "pass"}
    @user = User.new(stuff)
    @job=FactoryGirl.build(:job)
    @user.save.should==true
    @job.save.should==true
  end

  it "should be valid" do
    FactoryGirl.build(:user).should be_valid
  end

end
