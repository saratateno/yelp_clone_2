require 'rails_helper'

feature "endorsing reviews" do
  before do
    kfc = Restaurant.create(name: "KFC")
    kfc.reviews.create(rating: 3, opinion: "It was an abomination")
  end

  scenario "a user can endorse a review, which increments endorsement count", js: true do
    visit '/restaurants'
    click_link "Endorse review"
    expect(page).to have_content("1 endorsement")
  end
end
