require 'rails_helper'

describe 'the signout process' do
  before :each do visit '/'
  end

  scenario 'user can signout' do
    click_on 'Sign Up'

    fill_in 'First name', :with => 'Bob'
    fill_in 'Last name', :with => 'Barker'
    fill_in 'Email', :with => 'bob@1.com'
    fill_in 'Password', :with => '123'
    fill_in 'Password confirmation', :with => '123'

    click_button 'Create User'

    expect(page).to have_content 'Bob Barker'

    click_on 'Sign Out'

    expect(page).to have_no_content 'Bob Barker'
  end
end
