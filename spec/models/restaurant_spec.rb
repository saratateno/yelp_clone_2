require 'rails_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

  it "is invalid when name has less than three characters" do
    restaurant = Restaurant.new(name: "Na")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end
end
