require 'rails_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }
  it { is_expected.to belong_to :user}

  it "is invalid when name has less than three characters" do
    restaurant = Restaurant.new(name: "Na")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is invalid when name is not unique" do
    Restaurant.create(name: "Hamid's Tavern")
    restaurant = Restaurant.new(name: "Hamid's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  describe 'reviews' do
    describe '#build_with_user' do
      let(:user) { User.create email: 'test@test.com' }
      let(:restaurant) { Restaurant.create name: 'Test' }
      let(:review_params) { {rating: 5, opinion: 'good food'} }

      subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

      it 'builds a review' do
        expect(review).to be_a Review
      end

      it 'builds a review associated with the specified user' do
        expect(review.user).to eq user
      end
    end
  end
end
