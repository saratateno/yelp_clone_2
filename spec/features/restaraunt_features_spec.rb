require "rails_helper"

feature "restaraunts" do
  context "No restaraunts have been added" do
    scenario "should display a prompt to add a restaurant" do
      visit "/restaurants"
      expect(page).to have_content "No restaraunts yet!"
      expect(page).to have_link "Add a restaurant"
    end
  end
end
