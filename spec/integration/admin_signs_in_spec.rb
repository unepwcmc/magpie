require 'spec_helper'

describe "Admin signs in" do
  it "displays the user's username after successful login" do
    FactoryGirl.create(:admin, email: "example@example.com", password: "secret", password_confirmation: "secret")

    visit "/admins/sign_in"
    fill_in "Email", with: "example@example.com"
    fill_in "Password", with: "secret"
    click_button "Sign in"

    expect(page).to have_selector(".alert-success", text: "Signed in successfully.")
  end
end
