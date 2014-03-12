require 'spec_helper'

describe Event do
	# testing DeleteEvent
  it "deletes an event with DeleteEvent" do
  	event = Event.create
  	resp = Event.DeleteEvent(event.id)
  	expect(Event.all).to eq([])
  	expect(resp).to eq(1)
  end

  it "returns -1 if event doesnt exist" do
  	resp = Event.DeleteEvent(2)
  	expect(resp).to eq(-1)
  end

  # testing AddUserAttending
  it "creates a new relationship with a user" do
  	user = User.create
  	event = Event.create
  	resp = event.AddUser(user)
  	expect(event.user_ids).to eq([1])
  	expect(user.event_ids).to eq([1])
  end

  it "return -1 if user is not class User" do
  	org = Organization.create
  	event = Event.create
  	resp = event.AddUser(org)
  	expect(resp).to eq(-1)
  end

  # testing DeleteUserAttending
  it "removes a user from the events users table" do
  	user = User.create
  	event = Event.create
  	event.users << user
  	resp = event.DeleteUser(user)
  	expect(user.event_ids).to eq([])
  	expect(event.user_ids).to eq([])
  end

  it "returns -1 if user is not class User" do
  	org = Organization.create
  	event = Event.create
  	resp = event.DeleteUser(org)
  	expect(resp).to eq(-1)
  end


end
