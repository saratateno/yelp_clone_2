def sign_up (email: "test@example.com", password: "password")
  click_link "Sign Up"
  fill_in "Email", with: email
  fill_in "Password", with: password
  fill_in "Password confirmation", with: password
  click_button "Sign Up"
end

def leave_review
  click_link "Review Nandos"
  fill_in "Opinion", with: "I don't even like chicken"
  select "3", from: "Rating"
  click_button "Leave Review"
end
