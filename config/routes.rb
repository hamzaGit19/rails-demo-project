# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  # get "users/new" => "users/registrations#new"

  get "register", to: "users#new"
  post "register", to: "users#add_user"

  namespace :dashboard do
    get "dashboard/index"
  end

  get "dashboard/index"
  root to: "pages#index"

  namespace :dashboard do
    root to: "dashboard#index"
  end

  namespace :admin do
    match ":id" => "users#destroy", :via => :delete, :as => :user_delete
    resources :users
  end

  namespace :manager do
    match ":id" => "users#destroy", :via => :delete, :as => :user_delete
    resources :users
  end

  resource :user, :controller => "users" do
    collection do
      get "change_password"
      patch "update_password"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
