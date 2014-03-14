require 'spec_helper'
require 'factory_girl_rails'
describe Event do
  #pending "add some examples to (or delete) #{__FILE__}"

  it "has valid factory" do
  	FactoryGirl.create(:event).should be_valid
  end

  it "is invalid without name" do
  	FactoryGirl.build(:event, name: nil).should_not be_valid
  end


  it "is invalid with name too long" do
  	FactoryGirl.build(:event, name: "a"*200).should_not be_valid
  end


  it "is invalid without location" do
  	FactoryGirl.build(:event, location: nil).should_not be_valid
  end



  it "is invalid with location too long" do
  	FactoryGirl.build(:event, location: "a"*200).should_not be_valid
  end



  it "is invalid without date" do
  	FactoryGirl.build(:event, date: nil).should_not be_valid
  end



  it "is invalid with description too long" do
  	FactoryGirl.build(:event, description: "a"*600).should_not be_valid
  end


  it "is invalid with link too long"

  it "deletes an event with DeleteEvent" do
  	@event1 = FactoryGirl.create(:event)
  	resp = Event.DeleteEvent(@event1.id)
  	expect(resp).to eq(1) 
  end

  it "returns -1 if event doesnt exist" do
  	resp = Event.DeleteEvent(2)
  	expect(resp).to eq(-1)
  end

  it "adds users correctly" do 
   
    @event1 = FactoryGirl.create(:event)

    stuff = {username: "eric", email: "eoneill@berkeley.edu", password: "pass", password_confirmation: "pass"}
    @user1 = User.new(stuff)
    @user1.save

    resp = @event1.AddUser(@user1)
    @event1.users.first.should == @user1
    resp.should == 1
  end

  it "deletes users correctly" do
    @event1 = FactoryGirl.create(:event)

    stuff = {username: "eric", email: "eoneill@berkeley.edu", password: "pass", password_confirmation: "pass"}
    @user1 = User.new(stuff)
    @user1.save

    resp = @event1.AddUser(@user1)
    resp.should ==1

    del_resp = @event1.DeleteUser(@user1)
    @event1.users.first.should == nil
    del_resp.should == 1
  end




end
