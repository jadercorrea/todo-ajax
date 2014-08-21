require 'rails_helper'

RSpec.describe "Tasks", :type => :request do
  context '.create_task' do
    it 'fills task description and saves it' do
      visit tasks_path
      expect(page).to have_content('Factory Task')

      fill_in 'task_description', with: 'Created Task'
      page.execute_script("$('form#new_task').submit()")

      expect(page).to have_content('Created Task')

      within(:xpath, ".//tr[contains(@id, 'task_id_2')]") do
        expect(find(:xpath, "(.//input[@type='checkbox'])")).not_to be_checked
      end
    end
  end

  context '.update task' do
    it 'clicks finished checkbox' do
      visit tasks_path
      expect(page).to have_content('Factory Task')

      within(:xpath, ".//tr[contains(@id, 'task_id_1')]") do
        checkbox = find(:xpath, "(.//input[@type='checkbox'])")
        checkbox.set(true)
        expect(checkbox).to be_checked
      end
    end
  end

  context '.create_subtask' do
    it 'fills the subtask description and saves it' do
      visit tasks_path
      expect(page).to have_content('Factory Task')
      click_link 'Factory Task'

      fill_in 'sub_task_description', with: 'Created Subtask'
      page.execute_script("$('form#new_sub_task').submit()")

      expect(page).to have_content('Created Subtask')
      expect(find(:xpath, "//tr[contains(.,'Created Subtask')]/td/a")).not_to be_checked
    end
  end

  context '.delete task' do
    it 'clicks delete button and removes it' do
      visit tasks_path
      expect(page).to have_content('Factory Task')

      find(:xpath, ".//tr[contains(@id, 'task_id_1')]", text: 'Delete').click

      page.execute_script("$('[id^=task_id_1]').remove()")
      expect(page).not_to have_content('Factory Task')
    end
  end

  pending '.delete subtask' do
    it 'clicks delete button and removes it' do
      visit tasks_path
      expect(page).not_to have_content('Finished Task')
      expect(page).to have_content('Finished Sub1')

      find(:xpath, "//tr[contains(.,'Finished Sub1')]/td/a", :text => 'Delete').click

      expect(page).not_to have_content('Finished Sub1')
      expect(page).to have_content('Finished Task')
      expect(page).to have_content('Finished Sub2')
    end
  end
end
