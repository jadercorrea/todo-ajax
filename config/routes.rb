Rails.application.routes.draw do
  resources :tasks
  resources :sub_tasks

  root :to => redirect('tasks')
end
