Rails.application.routes.draw do
  
  root to: 'visitors#index'
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users
  resources :projects do
    member do
      get 'invite_user'
    end
  end
  resources :tasks, only: [:new, :create, :destroy]
  get 'dashboard' => 'users#dashboard'
end
