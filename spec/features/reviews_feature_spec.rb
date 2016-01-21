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

  def sign_up
    click_link "Sign Up"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign Up"
  end

  def leave_review
    click_link "Review Nandos"
    fill_in "Opinion", with: "I don't even like chicken"
    select "3", from: "Rating"
    click_button "Leave Review"
  end

end
