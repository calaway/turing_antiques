require 'rails_helper'
RSpec.feature 'A user views their orders' do
  scenario 'they see all orders belonging to them' do
    user = create(:user_with_orders)
    order_1 = user.orders.first
    order_2 = user.orders.last

    visit login_path

    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Save Session'

    visit '/orders'

    expect(page).to have_content("Order #{order_1.id}: $#{order_1.price}")
    expect(page).to have_content("Order #{order_2.id}: $#{order_2.price}")
  end

  scenario "they don't see orders belonging to a different user" do
  end
end