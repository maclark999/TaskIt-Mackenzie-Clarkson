require 'rails_helper'

 describe 'User can CRUD tasks' do
   User.create(:first_name => 'Test', :last_name => 'Testy', :email => 'test@testy.com', :password => 'password')
   before :each do visit '/'
     click_link 'Sign In'
     fill_in :email, :with => 'test@testy.com'
     fill_in :password, :with => 'password'
     click_button 'Sign In'
     click_on 'Tasks'
   end

  scenario 'User can create new task' do
    click_on 'New Task'

    expect(page).to have_content ('New Task')

    fill_in 'task[description]', :with => 'testy'
    select '2015', :from => "task_due_date_1i"
    select 'March', :from => "task_due_date_2i"
    select '3', :from => "task_due_date_3i"

    click_on 'Create Task'

    expect(page).to have_content ('testy')
    expect(page).to have_content ('2015/03/03')

  end

  scenario 'User can visit task show page' do
    Task.create(:description => "testy")

    visit "tasks"

    click_on 'testy'

    expect(page).to have_content ('testy')

  end

  scenario 'User can edit task' do
    Task.create(:description => "testy")
    visit "tasks"

    click_on 'Edit'

    expect(page).to have_content ('Editing Task')

    fill_in 'task[description]', :with => "trest"

    click_on 'Update Task'

    expect(page).to have_content ('Task was successfully updated')
    expect(page).to have_content ('trest')

  end

  scenario 'User can delete task' do
    Task.create(:description => 'testy')
    visit 'tasks'

    click_on 'Delete'

    expect(page).to have_content ('Task was successfully destroyed')
    expect(page).to have_no_content('testy')
  end
 end
