require 'rails_helper'

describe 'User can CRUD projects' do
  User.create(:first_name => 'Test', :last_name => 'Testy', :email => 'test@testy.com', :password => 'password')
  before :each do visit '/'
    User.create(:first_name => 'Test', :last_name => 'Testy', :email => 'test@testy.com', :password => 'password')

    click_link 'Sign In'
    fill_in :email, :with => 'test@testy.com'
    fill_in :password, :with => 'password'
    click_button 'Sign In'
  end

  scenario 'User can create project' do
    within(".page-header") do
      click_link('New Project')
    end

    fill_in 'project[name]', :with => 'prooject'

    click_on 'Create Project'

    expect(page).to have_content ('prooject')
  end

  scenario 'User can visit project show page' do
    #Project.create(:name => 'prooject')
    within(".page-header") do
      click_link('New Project')
    end

    fill_in 'project[name]', :with => 'prooject'

    click_on 'Create Project'

    #find("a", :text => 'projects/1').click
    within(".breadcrumb") do
      click_link 'prooject'
    end
    expect(page).to have_content ('prooject')
  end

  scenario 'User can edit project' do
    within(".page-header") do
      click_link('New Project')
    end

    fill_in 'project[name]', :with => 'prooject'

    click_on 'Create Project'

    #find("a", :text => 'projects/1').click
    within(".breadcrumb") do
      click_link 'prooject'
    end

    click_on 'Edit'

    expect(page).to have_content ('Edit Project')
    fill_in 'project[name]', :with => 'prodject'

    click_on 'Update Project'
    expect(page).to have_content ('Project was successfully updated')
    expect(page).to have_content ('prodject')
  end

  scenario 'User can delete project' do

    within(".page-header") do
      click_link('New Project')
    end

    fill_in 'project[name]', :with => 'prooject'

    click_on 'Create Project'

    #find("a", :text => 'projects/1').click
    within(".breadcrumb") do
      click_link 'prooject'
    end

    within(".well") do
      click_on 'Delete'
    end

    expect(page).to have_content ('Project was successfully destroyed')
    expect(page).to have_no_content('prooject')
  end
end
