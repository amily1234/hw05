require 'rails_helper'

RSpec.feature "Tasks", type: :feature do

  context "create new task" do
    scenario 'should be successful' do
      visit new_task_path
      within('form') do
        fill_in '任務標題', with: '手作'
        fill_in '任務內容', with: '完成飾品擺飾'
      end
      click_on '新增Task'
      expect(page).to have_content('新增任務成功')
    end
  end

  context "update task" do
    scenario 'should be successful' do
      task = Task.create({title: "手作", content: "完成飾品擺飾"})
      visit edit_task_path(task)
      within('form') do
        fill_in '任務標題', with: '手作聚會'
      end
      click_on '更新Task'
      expect(page).to have_content('資料更新成功')
    end
  end

  context "destroy task" do
    scenario 'should be successful' do
      task = Task.create({title: "手作", content: "完成飾品擺飾"})
      visit tasks_path
      # accept_confirm do
        expect {click_link '刪除'}.to change(Task, :count).by(-1)
      # end      
      expect(page).to have_content('任務資料已刪除')
    end    
  end

end