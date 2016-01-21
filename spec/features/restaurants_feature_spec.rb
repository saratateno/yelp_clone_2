require "rails_helper"

feature "Restaurants" do

  context "no restaurants have been added" do
    scenario "should display a prompt to add a restaurant" do
      visit "/restaurants"
      expect(page).to have_content "No restaurants yet!"
      expect(page).to have_link "Add a restaurant"
    end

    context "creating restaurants" do

      context "when signed up" do

        before do
          visit "/restaurants"
          sign_up
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

      context "when not signed up" do

        before do
          visit "/restaurants"
          click_link "Add a restaurant"
        end

        it "inability to add restaurants" do
          expect(current_path).not_to eq "/restaurants/new"
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
    end

    context "prevents restaurant duplication" do
      scenario "restaurants added must be unique" do
        visit "/restaurants"
        sign_up
        click_link "Add a restaurant"
        fill_in "Name", with: "Nandos"
        click_button "Create Restaurant"
        expect(page).to have_content "error"
      end
    end
  end

  context "when user has created restaurant" do
    before do
      visit "/restaurants"
      sign_up
      click_link "Add a restaurant"
      fill_in "Name", with: "Nandos"
      click_button "Create Restaurant"
    end

    scenario "can edit own restaurant" do
      click_link "Edit Nandos"
      fill_in "Name", with: "Grilled Chicken"
      click_button "Update Restaurant"
      expect(page).to have_content "Grilled Chicken"
      expect(current_path).to eq "/restaurants"
    end

    scenario "can delete own restaurant" do
      click_link "Delete Nandos"
      expect(page).not_to have_css "h2", text: "Nandos"
      expect(page).to have_content "Nandos has been deleted"
    end
  end

  context "restaurants have been added by another user" do
    before do
      visit "/restaurants"
      sign_up
      click_link "Add a restaurant"
      fill_in "Name", with: "Nandos"
      click_button "Create Restaurant"
      click_link "Sign Out"
      sign_up(email:"new@example.com")
    end

    scenario "user cannot edit Nandos" do
      click_link "Edit Nandos"
      expect(current_path).to eq "/restaurants"
      expect(page).to have_content "Incorrect User"
    end

    scenario "user cannot delete Nandos" do
      click_link "Delete Nandos"
      expect(page).to have_css "h2", text: "Nandos"
      expect(page).to have_content "Incorrect User"
    end
  end
end
