require "rails_helper"

feature "restaraunts" do
  context "No restaraunts have been added" do
    scenario "should display a prompt to add a restaurant" do
      visit "/restaurants"
      expect(page).to have_content "No restaurants yet!"
      expect(page).to have_link "Add a restaurant"
    end
  end

  context "restaurants have been added" do
    before do
      Restaurant.create(name: "Nandos")
    end

    scenario "displays restaurants" do
      visit "/restaurants"
      expect(page).to have_content "Nandos"
      expect(page).not_to have_content "No restaraunts yet!"
    end
  end
end
