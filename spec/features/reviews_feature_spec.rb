require "rails_helper"

feature "reviewing" do
  let!(:nandos){Restaurant.create(name: "Nandos")}

  scenario "allows logged-in users to leave a review" do
    visit "/restaurants"
    sign_up
    leave_review

    expect(current_path).to eq "/restaurants"
    expect(page).to have_content "I don't even like chicken"
  end

  scenario "disallows non-logged-in users to leave a review" do
    visit "/restaurants"
    click_link "Review Nandos"
    expect(current_path).to eq "/users/sign_in"
  end

  scenario "disallows logged-in users to leave a second review" do
    visit "/restaurants"
    sign_up
    leave_review
    click_link "Review Nandos"
    expect(page).to have_content "Cannot review same restaurant twice"
    expect(current_path).to eq "/restaurants"
  end

  scenario "user can delete own reviews" do
    visit "/restaurants"
    sign_up
    leave_review
    click_link "Delete review"
    expect(page).not_to have_content "I don't even like chicken"
  end

  scenario "user can't delete someone else's review" do
    visit "/restaurants"
    sign_up
    leave_review
    click_link "Sign Out"
    sign_up(email: "me@email.com")
    click_link "Delete review"
    expect(page).to have_content "I don't even like chicken"
    expect(page).to have_content "Incorrect User"
  end

  scenario 'displays an average rating for all reviews' do
    visit "/restaurants"
    sign_up
    leave_review(opinion: 'So so', rating: '3')
    click_link "Sign Out"
    sign_up(email: "you@email.com")
    leave_review(opinion: 'Great', rating: '5')
    expect(page).to have_content('Average rating: 4')
  end
end
