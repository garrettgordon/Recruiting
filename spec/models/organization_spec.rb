require 'spec_helper'
require 'organization'

describe Organization do
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
end


