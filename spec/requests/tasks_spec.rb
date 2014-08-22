require 'rails_helper'

RSpec.describe "Tasks", :type => :request do
  context '.create_task' do
    it 'fills task description and saves it' do
      visit tasks_path
      fill_in 'task_description', with: 'Create task'
      page.execute_script("$('form#new_task').submit()")

      expect(page).to have_content('Create task')
      last_task_id = Task.last.id.to_s

      within(:xpath, ".//tr[contains(@id, 'task_id_#{last_task_id}')]") do
        expect(find(:xpath, "(.//input[@type='checkbox'])")).not_to be_checked
      end
    end
  end

  context '.update_task' do
    it 'clicks finished checkbox' do
      visit tasks_path
      fill_in 'task_description', with: 'Update task'
      page.execute_script("$('form#new_task').submit()")

      expect(page).to have_content('Update task')
      last_task_id = Task.last.id.to_s

      within(:xpath, ".//tr[contains(@id, 'task_id_#{last_task_id}')]") do
        checkbox = find(:xpath, "(.//input[@type='checkbox'])")
        checkbox.set(true)
        expect(checkbox).to be_checked
      end
    end
  end

  context '.create_subtask' do
    it 'fills the subtask description and saves it' do
      visit tasks_path
      fill_in 'task_description', with: 'Create subtask parent'
      page.execute_script("$('form#new_task').submit()")

      expect(page).to have_content('Create subtask parent')

      click_link 'Create subtask parent'
      fill_in 'task_description', with: 'Create subtask children'
      page.execute_script("$('form#new_task').submit()")

      expect(page).to have_content('Create subtask children')
      expect(page).not_to have_content('Create subtask parent')
    end
  end

  context '.delete_task' do
    it 'clicks delete button and removes it' do
      visit tasks_path
      fill_in 'task_description', with: 'Delete task'
      page.execute_script("$('form#new_task').submit()")

      expect(page).to have_content('Delete task')
      last_task_id = Task.last.id.to_s

      page.execute_script("$('[id^=task_id_#{last_task_id}]').remove()")
      expect(page).not_to have_content('Delete task')
    end
  end

  context '.delete_subtask' do
    it 'clicks delete button and removes it' do
      visit tasks_path
      fill_in 'task_description', with: 'Delete subtask parent'
      page.execute_script("$('form#new_task').submit()")

      expect(page).to have_content('Delete subtask parent')

      click_link 'Delete subtask parent'
      fill_in 'task_description', with: 'Delete subtask children'
      page.execute_script("$('form#new_task').submit()")

      expect(page).to have_content('Delete subtask children')
      last_task_id = Task.last.id.to_s

      page.execute_script("$('[id^=task_id_#{last_task_id}]').remove()")
      expect(page).not_to have_content('Delete subtask children')
    end
  end

  context '.update_sub_task' do
    it 'clicks finished checkbox' do
      visit tasks_path
      fill_in 'task_description', with: 'Update subtask parent'
      page.execute_script("$('form#new_task').submit()")

      expect(page).to have_content('Update subtask parent')

      click_link 'Update subtask parent'
      fill_in 'task_description', with: 'Update subtask children'
      page.execute_script("$('form#new_task').submit()")

      expect(page).to have_content('Update subtask children')
      last_task_id = Task.last.id.to_s

      within(:xpath, ".//tr[contains(@id, 'task_id_#{last_task_id}')]") do
        checkbox = find(:xpath, "(.//input[@type='checkbox'])")
        checkbox.set(true)
        expect(checkbox).to be_checked
      end
    end
  end
end
