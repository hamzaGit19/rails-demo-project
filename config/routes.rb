# frozen_string_literal: true

Rails.application.routes.draw do
  get "projects/:project_id/time_logs/:id", to: "time_logs#show", as: "project_time_log_path"
  get "projects/:project_id/payments/:id", to: "payments#show", as: "project_payment_path"

  namespace :admin do
    get "projects/index"
    get "projects/show"
  end

  namespace :api do
    namespace :v1 do
      devise_for :users, skip: :all
      devise_scope :user do
        post "users", to: "sessions#create", as: nil
      end
      namespace :admin do
        match ":id" => "users#destroy", :via => :delete, :as => :user_delete
        resources :users
        resources :clients
        resources :projects do
          resources :payments
          resources :time_logs
        end
      end
      namespace :manager do
        resources :clients
        resources :projects do
          resources :payments
          resources :time_logs
        end
      end
      namespace :employee do
        resources :clients, only: %i[index show]
        resources :projects do
          resources :time_logs
        end
      end
      resources :comments
      resources :projects
    end
  end

  devise_for :users, controllers: { registrations: "users/registrations" }

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
    resources :clients
    resources :projects do
      resources :payments
      resources :time_logs
    end
  end

  namespace :manager do
    resources :clients
    resources :projects do
      resources :payments
      resources :time_logs
    end
  end
  namespace :employee do
    resources :clients, only: %i[index show]
    resources :projects do
      resources :time_logs
    end
  end
  resources :comments

  resource :user, controller: "users" do
    collection do
      get "change_password"
      patch "update_password"
    end
  end

  get "*path", controller: "application", action: "page_not_found"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
