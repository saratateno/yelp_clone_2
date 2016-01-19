require "rails_helper"

feature "reviewing" do
  let!(:nandos){Restaurant.create(name: "Nandos")}

  scenario "allows users to leave a review" do
    visit "/restaurants"
    click_link "Review Nandos"
    fill_in "Opinion", with: "I don't even like chicken"
    select "3", from: "Rating"
    click_button "Leave Review"

    expect(current_path).to eq "/restaurants"
    expect(page).to have_content "I don't even like chicken"
  end

end
