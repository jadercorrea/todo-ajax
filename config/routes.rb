Rails.application.routes.draw do
  resources :tasks, only: [:index, :show, :create, :update, :destroy]

  root :to =>  "tasks#index"
end
