# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'users/index'
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :user_delete
  devise_for :users
  namespace :dashboard do
    get 'dashboard/index'
  end
  get 'dashboard/index'
  root to: 'pages#index'
  namespace :dashboard do
    root to: 'dashboard#index'
  end
  namespace :admin do 
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
