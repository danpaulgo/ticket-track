require 'rails_helper'

RSpec.describe Performer, type: :model do

	it 'has all necessary fields' do
    expect(Performer.new).to respond_to(:name)
  end

  it "is valid with a name" do
    expect(performer).to be_valid
  end

  it "is invalid without a name" do
  	performer.name = nil
  	expect(performer).not_to be_valid
  	performer.name = ""
  	expect(performer).not_to be_valid
  end

end
