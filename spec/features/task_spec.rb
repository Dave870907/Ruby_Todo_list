require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  before :context do
    User.new(user_name: 'Dave').save
  end
  
  context "create new tasks" do 

    scenario "successfully create" do 
      visit '/tasks/new'
      within('#new_task') do 
        fill_in 'task_title',with: 'test'
        find(:css, '#task_order_0').click
        fill_in 'task_user_id', with: User.first.id
      end
      click_button 'commit'
      expect(page).to have_content(I18n.t('notice.new'))
    end
    scenario "create fail" do
      visit '/tasks/new' 
      click_button 'commit'
      expect(page).to have_content(I18n.t('errors.messages.blank'))
    end
  end
    
  context 'update tasks' do 
    scenario 'successfully update' do
      task = Task.create(title:'title',start_time: DateTime.now,end_time: DateTime.now, 
        status: 'pending',category:'0',content:'content',order:0,user: User.first)
      visit "/tasks/#{Task.first.id}/edit"
      within('form') do 
        fill_in 'task_content',with: 'content update test'
      end
      click_button 'commit'
      expect(page).to have_content(I18n.t('notice.update'))
    end
  end

  context 'delete tasks' do
    scenario 'successfully delete' do 
      task = Task.create(title:'title',start_time: DateTime.now,end_time: DateTime.now, 
        status: 'pending' ,category:'0',content:'content',order:0 ,user: User.first)
      visit "/tasks"
      
      click_link(href: "/tasks/#{task.id}")

      expect(page).to have_content(I18n.t('notice.delete'))
      end
    end
  context 'sort tasks by different ways' do
    let!(:tasks) do
      task1 = Task.create(id:0,title:'title1',created_at:DateTime.now,start_time: DateTime.now,end_time: DateTime.now, 
        status: 'pending' ,category:'0',content:'content',order: 0 ,user: User.first)
      task2 = Task.create(id:1,title:'title2',created_at:DateTime.now+1.hour,start_time: DateTime.now+1.weeks,end_time: DateTime.now+1.weeks, 
        status: 'process' ,category:'0',content:'content',order: 1 ,user: User.first)
      end
      
    scenario 'sort by created_at' do 
      visit "/tasks"
           
      expect(page).to have_css('#task_table tbody :nth-child(1) td', :text => "title1")
      click_link Task.human_attribute_name(:created_at)
      expect(page).to have_css('#task_table tbody :nth-child(1) td', :text => "title2")
    end
    scenario 'sort by end_time' do 
      visit "/tasks"

      expect(page).to have_css('#task_table tbody :nth-child(1) td', :text => "title1")
      click_link Task.human_attribute_name(:end_time)
      expect(page).to have_css('#task_table tbody :nth-child(1) td', :text => "title2")
    end

    scenario 'sort by order' do 
      visit "/tasks"

      expect(page).to have_css('#task_table tbody :nth-child(1) td', :text => "title1")
      click_link Task.human_attribute_name(:order)
      expect(page).to have_css('#task_table tbody :nth-child(1) td', :text => "title2")
    end

    scenario "search by title" do 
      visit "/tasks"

      within('#task_search') do 
        fill_in 'q_title_cont' ,with: 'title2'
        click_button 'commit'
      end
      expect(page).to have_no_content('/title1/')
    end

    scenario "filter by status" do 
      visit "/tasks"
      within('#task_search') do 
        find(:css , '#q_status_eq_process').click
        click_button 'commit'
      end
      expect(page).to have_no_content('/title1/')
    end
  end

end
