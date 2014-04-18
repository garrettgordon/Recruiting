require 'spec_helper'
require 'organization'

describe Organization do
  include Authlogic::TestCase
  before (:each) do
    activate_authlogic
  end
  it "should store Organization info" do
    org=Organization.new
    org.name="Company"
    org.description="Description"
    org.location="San Diego"
    bool=org.save
    bool.should be_true
    expect(org.name).to eq("Company")
    expect(org.description).to eq("Description")
    expect(org.location).to eq("San Diego")
  end

  it "should not allow organizations without a name to save" do
    org=Organization.new
    org.description="Description"
    org.location="San Diego"
    bool=org.save
    bool.should be_false
  end

  it "should be sorted by most applicants" do
    org1=Organization.new
    org1.name="Company"
    org1.description="Description"
    org1.location="San Diego"
    org1.save
    org2=Organization.new
    org2.name="Comp"
    org2.description="Description"
    org2.location="San Diego"
    org2.save
    org3=Organization.new
    org3.name="Co"
    org3.description="Description"
    org3.location="San Diego"
    org3.save
    @usr2 = FactoryGirl.create(:user, :username => "fred", :email => "blah@berkeley.edu", :id => 2)
    @usr2.save
    @user_session2 = UserSession.create(@usr2)
    @usr3 = FactoryGirl.create(:user, :username => "bob", :email => "bleh@berkeley.edu" , :id => 3)
    @usr3.save
    @user_session3 = UserSession.create(@usr3)
    @usr4 = FactoryGirl.create(:user, :username => "joe", :email => "blh@berkeley.edu", :id => 4)
    @usr4.save
    @user_session4 = UserSession.create(@usr4)
    @job1 = FactoryGirl.create(:job)
    @job1.save
    @job2 = FactoryGirl.create(:job)
    @job2.save
    @job3 = FactoryGirl.create(:job)
    @job3.save
    @job4 = FactoryGirl.create(:job)
    @job4.save
    @job5 = FactoryGirl.create(:job)
    @job5.save
    @job6 = FactoryGirl.create(:job)
    @job6.save


    @job1.organization=org1
    @job2.organization=org1
    @job3.organization=org2
    @job4.organization=org2
    @job5.organization=org3
    @job6.organization=org3

    @usr2.jobs << @job1
    @usr2.jobs << @job2
    @usr2.jobs << @job3
    @usr2.jobs << @job4
    @usr2.jobs << @job5
    @usr2.jobs << @job6

    @usr3.jobs << @job3
    @usr3.jobs << @job4
    @usr3.jobs << @job5
    @usr3.jobs << @job6

    @usr4.jobs << @job5
    @usr4.jobs << @job6
    
    @usr2.save
    @usr3.save
    @usr4.save
    
    @job1.save
    @job2.save
    @job3.save
    @job4.save
    @job5.save
    @job6.save

    org1.save
    org2.save
    org3.save

    @usr2.jobs.length.should==6
    @organizations=Organization.text_search("C")
    @organizations.length.should==3
    organizations=Organization.readySort(@organizations)
    organizations.last.should==[org3, 6]
    organizations=Organization.mergeSort(organizations)
    @organizations=Organization.listConvert(organizations)
    @organizations.length.should==3
    @organizations.first.should==org3
    @organizations.last.should==org1
  end
end


