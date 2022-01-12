require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'validation tests' do

    let!(:new_task) {
      @user = User.create(user_name: 'user', email: '00@example.com', password: '00')
      @task = Task.new(title:'title',start_time: DateTime.now,end_time: DateTime.now, 
        status: 'pending',category:'hi',content:'content',order:0,user: @user)
    }

    it 'ensure start time presence' do
      @task.start_time = nil
      expect(@task.save).to eq(false)
    end
    it 'ensure end time presence' do 
      @task.end_time = nil
      expect(@task.save).to eq(false)
        
    end

    it 'ensure end time > start time' do
      @task.start_time = DateTime.now + 1.week
      expect(@task.save).to eq(false)
    end

    it 'ensure order and status presence' do 
      @task.status = nil
      @task.order = nil
      expect(@task.save).to eq(false)
    end
    it 'ensure title presence' do 
      @task.title = nil
      expect(@task.save).to eq(false)
    end


    # (need to be change after creating membership system)
    it 'ensure be built by existed user' do
      @task.user= nil
      expect(@task.save).to eq(false)  
    end

    it 'should save successfully' do
      expect(@task.save).to eq(true)
    end
  end
  
end
