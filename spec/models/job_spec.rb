require 'spec_helper'
require 'job'
describe Job do
  include Authlogic::TestCase
  before(:each) do
    activate_authlogic
    @usr1 = FactoryGirl.create(:user)
    @user_session1 = UserSession.create(@usr1)
    @job1 = FactoryGirl.create(:job)
    @org1= FactoryGirl.create(:organization)
  end

  it "can be created" do
  	stuff= {title: "first job", description: "description of first job"}
  	jb= Job.new(stuff)
  	sve=jb.save
  	sve.should==true
  end

  it "can be retrieved" do
  	@job1.save.should==true
  	found=Job.find_by_title("MyString")
  	(found.nil?).should==false
  end

  it "has many users" do
  	@usr2 = FactoryGirl.create(:user, :username => "fred", :email => "blah@berkeley.edu", :id => 2)
  	@user_session2 = UserSession.create(@usr2)
  	@usr3 = FactoryGirl.create(:user, :username => "bob", :email => "bleh@berkeley.edu" , :id => 3)
    @user_session3 = UserSession.create(@usr3)
    @job1.users << @usr2
    @job1.users << @usr3
    @job1.users.first.should==@usr2
    @job1.users.last.should==@usr3
    @usr4 = FactoryGirl.create(:user, :username => "george", :email => "blh@berkeley.edu" , :id => 4)
    @user_session4 = UserSession.create(@usr4)
    id=@usr4[:id]
    sol=@job1.addUser(id)
    sol.should==1
    @job1.users.last.should==@usr4

  end

  it "can remove users" do
  	@usr2 = FactoryGirl.create(:user, :username => "fred", :email => "blah@berkeley.edu", :id => 2)
  	@user_session2 = UserSession.create(@usr2)
  	@usr3 = FactoryGirl.create(:user, :username => "bob", :email => "bleh@berkeley.edu" , :id => 3)
    @user_session3 = UserSession.create(@usr3)
    @job1.users << @usr2
    @job1.users << @usr3
    @job1.users.delete(@usr2)
    @job1.users.first.should==@usr3
    @usr4 = FactoryGirl.create(:user, :username => "george", :email => "blh@berkeley.edu" , :id => 4)
    @user_session4 = UserSession.create(@usr4)
    @job1.users << @usr4
    @job1.removeUser(@usr4[:id])
    @job1.users.last.should==@usr3
  end


  it " belongs to one organization" do
  	@job1.organization= @org1
  	@job1.organization.should==@org1
  end

  it "can add tags" do
  	@job1.addSkillTag("talented")
  	@job1.addSkillTag("really talented")
  	@job1.addCourseTag("awesomeness101")
  	@job1.addCourseTag("awesomeness102")
  	l1=@job1.skill_list
  	l1.include?("talented").should==true
  	l1.include?("really talented").should==true
  	l2=@job1.course_list
  	l2.include?("awesomeness101").should==true
  	l2.include?("awesomeness102").should==true
  end

  it  "can remove tags" do

  	@job1.addSkillTag("talented")
    @job1.addSkillTag("really talented")
  	@job1.addCourseTag("awesomeness101")
  	@job1.addCourseTag("awesomeness102")
  	@job1.removeSkillTag("talented")
  	@job1.removeCourseTag("awesomeness102")
    l1=@job1.skill_list

  	l1.include?("talented").should==false
  	l1.include?("awesomeness101").should==false
  	l2=@job1.course_list
  	l2.include?("awesomeness102").should==false
  end

  it "can change application status" do
    @usr2 = FactoryGirl.create(:user, :username => "fred", :email => "blah@berkeley.edu", :id => 2)
    @user_session2 = UserSession.create(@usr2)
    @usr2.jobs << @job1
    (@usr2.jobs.include?(@job1)).should==true
    ja=Jobapp.find_by_user_id_and_job_id(@usr2[:id], @job1[:id])
    ja.nil?.should==false
    jas=Jobapp.where(:user_id => @usr2[:id])
    jas.nil?.should==false
    jas.length.should==1
    x=@job1.changeAppStatus(@usr2[:id], 1)
    x.should==1
  end

end
