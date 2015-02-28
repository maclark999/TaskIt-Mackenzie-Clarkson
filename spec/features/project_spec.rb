require 'rails_helper'

describe 'User can CRUD projects' do
  User.create(:first_name => 'Test', :last_name => 'Testy', :email => 'test@testy.com', :password => 'password')
  before :each do visit '/'
    User.create(:first_name => 'Test', :last_name => 'Testy', :email => 'test@testy.com', :password => 'password')

    click_link 'Sign In'
    fill_in :email, :with => 'test@testy.com'
    fill_in :password, :with => 'password'
    click_button 'Sign In'
    click_on 'Projects'
  end

  scenario 'User can create project' do
    click_on 'New Project'

    fill_in 'project[name]', :with => 'prooject'

    click_on 'Create Project'

    expect(page).to have_content ('prooject')
  end

  scenario 'User can visit project show page' do
    Project.create(:name => 'prooject')
    visit 'projects'

    click_on 'prooject'

    expect(page).to have_content ('prooject')
  end

  scenario 'User can edit project' do
    Project.create(:name => 'prooject')
    visit 'projects'

    click_on 'Edit'

    expect(page).to have_content ('Edit Project')
    fill_in 'project[name]', :with => 'prodject'

    click_on 'Update Project'
    expect(page).to have_content ('Project was successfully updated')
    expect(page).to have_content ('prodject')
  end

  scenario 'User can delete project' do
    Project.create(:name => 'prooject')
    visit 'projects'

    click_on 'Delete'
    expect(page).to have_content ('Project was successfully destroyed')
    expect(page).to have_no_content('prooject')
  end
end
