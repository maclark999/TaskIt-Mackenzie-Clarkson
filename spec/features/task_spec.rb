require 'rails_helper'

 describe 'User can CRUD tasks' do
   before :each do
     visit '/'

   User.create(:first_name => 'Test', :last_name => 'Testy', :email => 'test@testy.com', :password => 'password')
   @project = Project.create(:name => 'Project')

     click_link 'Sign In'
     fill_in :email, :with => 'test@testy.com'
     fill_in :password, :with => 'password'
     click_button 'Sign In'
     click_on 'Projects'
     click_link 'Project'
   end

  scenario 'User can create new task' do

    click_on '0 Tasks'

    expect(page).to have_content ('Tasks for Project')

    click_link 'New Task'

    fill_in 'task[description]', :with => 'Test'
    select '2015', :from => "task_due_date_1i"
    select 'March', :from => "task_due_date_2i"
    select '3', :from => "task_due_date_3i"

    click_on 'Create Task'

    expect(page).to have_content ('Test')
    expect(page).to have_content ('2015/03/03')

  end

  scenario 'User can visit task show page' do
    click_on '0 Tasks'

    expect(page).to have_content ('Tasks for Project')

    click_link 'New Task'

    fill_in 'task[description]', :with => 'test'
    select '2015', :from => "task_due_date_1i"
    select 'March', :from => "task_due_date_2i"
    select '3', :from => "task_due_date_3i"

    click_on 'Create Task'

    click_link 'test'

    expect(page).to have_content ('test')

  end

  scenario 'User can edit task' do
    click_on '0 Tasks'

    expect(page).to have_content ('Tasks for Project')

    click_link 'New Task'

    fill_in 'task[description]', :with => 'Test'
    select '2015', :from => "task_due_date_1i"
    select 'March', :from => "task_due_date_2i"
    select '3', :from => "task_due_date_3i"

    click_on 'Create Task'

    click_on 'Edit'

    expect(page).to have_content ('Editing Task')

    fill_in 'task[description]', :with => "trest"

    click_on 'Update Task'

    expect(page).to have_content ('Task was successfully updated')
    expect(page).to have_content ('trest')

  end

  scenario 'User can delete task' do
    click_on '0 Tasks'

    expect(page).to have_content ('Tasks for Project')

    click_link 'New Task'

    fill_in 'task[description]', :with => 'test'
    select '2015', :from => "task_due_date_1i"
    select 'March', :from => "task_due_date_2i"
    select '3', :from => "task_due_date_3i"

    click_on 'Create Task'
    visit 'tasks'

    click_link('delete_link')
    # '', :href => "/projects/8/tasks/1"
    expect(page).to have_content ('Task was successfully destroyed')
    expect(page).to have_no_content('test')
  end
 end
