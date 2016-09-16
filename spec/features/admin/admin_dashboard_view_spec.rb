require 'rails_helper'

RSpec.feature 'Admin can log in and redirected to Admin Dashboard' do
  scenario 'Admin sees admin dashboard upon login' do
  # As an Admin
  admin = create(:user, role: 1)

  visit login_path

  fill_in 'Username', with: admin.username
  fill_in 'Password', with: admin.password

  click_on 'Save Session'

  # When I visit "/admin/dashboard"
  expect(current_path).to eq(admin_dashboard_index_path)
  # I will see a heading on the page that says "Admin Dashboard"
  expect(page).to have_content('Admin Dashboard')


  end

  scenario 'Registered user does not get to see admin dashboard' do
    # As a registered user
    user = create(:user)

    visit login_path

    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password

    # When I visit "/admin/dashboard"
    visit admin_dashboard_index_path

    # I get a 404
    expect(page).to have_content('404')
    expect(page).to_not have_content('Admin Dashboard')
  end

  scenario 'Visitor does not get to see admin dashboard' do
    # As an unregistered user
    # When I visit "/admin/dashboard"
    visit admin_dashboard_index_path

    # I get a 404
    expect(page).to have_content('404')
    expect(page).to_not have_content('Admin Dashboard')
  end
end
