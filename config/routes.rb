Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks, except: %I(update edit)
end
