require 'rails_helper'

describe 'the signin process' do
  User.create(:last_name => 'barker', :first_name => 'bob', :email => 'bob@bob.com', :password => 'barker')
  before :each do visit '/'
  end
  scenario 'user cannot sign in with invalid information' do
    click_on 'Sign In'

    fill_in :email, :with => 'bob@blob.com'
    fill_in :password, :with => '123'

    click_button "Sign In"

    expect(page).to have_content ('Email/password combination is invalid')

  end

  scenario 'user can sign in with valid information' do
    click_on 'Sign In'

    fill_in :email, :with => 'bob@bob.com'
    fill_in :password, :with => 'barker'

    click_button 'Sign In'

    expect(page).to have_content ('bob barker')
  end
end
