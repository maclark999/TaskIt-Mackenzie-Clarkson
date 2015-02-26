require 'rails_helper'

describe 'the signup process' do
  before :each do visit '/'
  end

scenario 'User cannot signup with invalid data' do
  click_on 'Sign Up'

  fill_in 'First name', :with => 'Bob'
  fill_in 'Last name', :with => 'Barker'
  fill_in 'Email', :with => 'bob@1.com'
  fill_in 'Password', :with => '123'
  fill_in 'Password confirmation', :with => '12'

  click_button 'Create User'

  expect(page).to have_content "Password confirmation doesn't match Password"
end

scenario 'User can signup with valid data' do
  click_on 'Sign Up'

  fill_in 'First name', :with => 'Bob'
  fill_in 'Last name', :with => 'Barker'
  fill_in 'Email', :with => 'bob@1.com'
  fill_in 'Password', :with => '123'
  fill_in 'Password confirmation', :with => '123'

  click_button 'Create User'

  expect(page).to have_content 'Bob Barker'
end
end
