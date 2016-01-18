require "rails_helper"

feature "Restaurants" do
  context "no restaurants have been added" do
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
      expect(page).not_to have_content "No restaurants yet!"
    end
  end

  context "creating restaurants" do
    scenario "ability to add restaurants" do
      visit "/restaurants"
      click_link "Add a restaurant"
      expect(current_path).to eq "/restaurants/new"
      fill_in "Name", with: "Nandos"
      click_button "Create Restaurant"
      expect(page).to have_content "Nandos"
      expect(current_path).to eq "/restaurants"
    end
  end
end
