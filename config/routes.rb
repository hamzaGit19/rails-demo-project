# frozen_string_literal: true

Rails.application.routes.draw do
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
    match ':id' => 'users#destroy', :via => :delete, :as => :user_delete
    resources :users
  end

 resource:user, :controller => 'users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
