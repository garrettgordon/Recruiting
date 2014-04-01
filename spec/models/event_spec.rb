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

  it "deletes an event with DeleteEvent" do
  	@event1 = FactoryGirl.create(:event)
  	resp = Event.DeleteEvent(@event1.id)
  	expect(resp).to eq(1) 
  end

  it "returns -1 if event doesnt exist" do
  	resp = Event.DeleteEvent(2)
  	expect(resp).to eq(-1)
  end

end
