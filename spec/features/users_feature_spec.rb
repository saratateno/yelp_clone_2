require 'rails_helper'

feature "User can sign in and out" do
  context "when user not signed in and on homepage" do
    it "should see 'sign in' and 'sign up' links" do
      visit "/"
      expect(page).to have_link "Sign In"
      expect(page).to have_link "Sign Up"
    end

    it "should not see 'sign out' link" do
      visit "/"
      expect(page).not_to have_link "Sign Out"
    end
  end

  context "when user is signed in and on homepage" do
    before do
      visit "/"
      click_link "Sign Up"
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_button "Sign Up"
    end

    it "should see 'sign out' link" do
      visit "/"
      expect(page).to have_link "Sign Out"
    end

    it "should see neither 'sign in' nor 'sign up' link'" do
      visit "/"
      expect(page).not_to have_link "Sign Up"
      expect(page).not_to have_link "Sign In"
    end
  end
end
