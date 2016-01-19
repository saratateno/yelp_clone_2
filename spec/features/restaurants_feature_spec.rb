require "rails_helper"

feature "Restaurants" do

  context "no restaurants have been added" do
    scenario "should display a prompt to add a restaurant" do
      visit "/restaurants"
      expect(page).to have_content "No restaurants yet!"
      expect(page).to have_link "Add a restaurant"
    end

    context "creating restaurants" do
      before do
        visit "/restaurants"
        click_link "Add a restaurant"
      end

      scenario "ability to add restaurants" do
        expect(current_path).to eq "/restaurants/new"
        fill_in "Name", with: "Nandos"
        click_button "Create Restaurant"
        expect(page).to have_content "Nandos"
        expect(current_path).to eq "/restaurants"
      end

      context "an invalid restaurant" do
        scenario "does not let you submit a name that is too short" do
          fill_in "Name", with: 'Na'
          click_button "Create Restaurant"
          expect(page).not_to have_css "h2", text: "Na"
          expect(page).to have_content "error"
        end
      end
    end
  end

  context "restaurants have been added" do
    let!(:nandos){Restaurant.create(name: "Nandos")}

    scenario "displays restaurants" do
      visit "/restaurants"
      expect(page).to have_content "Nandos"
      expect(page).not_to have_content "No restaurants yet!"
    end

    context "viewing restaurants" do
      scenario "lets a user view a restaurant" do
        visit "/restaurants"
        click_link "Nandos"
        expect(page).to have_content "Nandos"
        expect(current_path).to eq "/restaurants/#{nandos.id}"
      end

      scenario "lets a user edit a restaurant" do
        visit "/restaurants"
        click_link "Edit Nandos"
        fill_in "Name", with: "Grilled Chicken"
        click_button "Update Restaurant"
        expect(page).to have_content "Grilled Chicken"
        expect(current_path).to eq "/restaurants"
      end
    end

    context "lets user delete restaurants" do
      scenario "removes a restaurant when user clicks a delete link" do
        visit "/restaurants"
        click_link "Delete Nandos"
        expect(page).not_to have_css "h2", text: "Nandos"
        expect(page).to have_content "Nandos has been deleted"
      end
    end
  end
end
