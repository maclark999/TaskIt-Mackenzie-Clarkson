require 'rails_helper'

describe 'User can CRUD users' do
  before :each do visit '/'
        click_on 'Users'
      end

  scenario 'User can create a new user' do
    click_on "New User"
    expect(page).to have_content('New User')

    fill_in 'user[first_name]', :with => 'mister'
    fill_in 'user[last_name]', :with => 'bojangles'
    fill_in 'user[email]', :with => 'bojangely@jangles.com'

    click_on 'Create User'

    expect(page).to have_content('User was successfully created')
    expect(page).to have_content('mister')
    expect(page).to have_content('bojangles')
    expect(page).to have_content('bojangely@jangles.com')
  end

  scenario 'User can view show page for particular user' do
    User.create(:first_name => 'mister', :last_name => 'bojangles', :email => 'bojangles@j.com')

    visit 'users'

    click_on "mister"

    expect(page).to have_content('mister bojangles')
    expect(page).to have_content('bojangles@j.com')
  end

  scenario 'User can edit a user' do
    User.create(:first_name => 'mister', :last_name => 'bojangles', :email => 'bojangles@j.com')

    visit 'users'

    click_on "mister"

    expect(page).to have_content('mister bojangles')
    expect(page).to have_content('bojangles@j.com')

    click_on 'Edit'

    expect(page).to have_content('Edit User')

    fill_in'user[first_name]', :with => 'mrs'
    click_on 'Update User'

    expect(page).to have_content('mrs')
  end

  scenario 'User can delete a user' do
    User.create(:first_name => 'mister', :last_name => 'bojangles', :email => 'bojangles@j.com')

    visit 'users'

    click_on 'Delete'

    expect(page).to have_content('User was successfully destroyed')
    expect(page).to have_no_content('mrs')
  end

end
