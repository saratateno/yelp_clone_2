require 'rails_helper'

describe User, type: :model do
  it { is_expected.to have_many :reviews}
  it { is_expected.to have_many :reviewed_restaurants }
  describe "#has_reviewed?" do
    it "is false without reviewed restaurants" do
      restaurant = Restaurant.new
      user = User.new
      expect(user.has_reviewed?(restaurant)).to be false
    end

    xit "is true with reviewed restaurants" do
      user = User.new
    end
  end
end
