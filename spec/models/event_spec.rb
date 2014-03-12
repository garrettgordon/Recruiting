require 'spec_helper'

describe Event do
	# testing DeleteEvent
  it "deletes an event with DeleteEvent" do
  	event = Event.create
  	resp = Event.DeleteEvent(event.id)
  	expect(Event.all).to eq([])
  	expect(resp).to eq(1)
  end

  # testing AddUserAttending
  it "creates a new relationship with a user" do
  	user = User.create
  	event = Event.create
  	resp = Event.AddUserAttending(user.id,event.id)
  	expect(event.user_ids).to eq([1])
  	expect(user.event_ids).to eq([1])
  end
end
