# frozen_string_literal: true

Rails.application.routes.draw do
  get 'projects/:project_id/time_logs/:id', to: 'time_logs#show', as: 'project_time_log_path'
  get 'projects/:project_id/payments/:id', to: 'payments#show', as: 'project_payment_path'

  namespace :admin do
    get 'projects/index'
    get 'projects/show'
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # get 'users/new' => 'users/registrations#new'

  get 'register', to: 'users#new'
  post 'register', to: 'users#add_user'

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
    resources :clients
    resources :projects do
      resources :payments
      resources :time_logs
    end
  end

  namespace :manager do
    # match ':id' => 'users#destroy', :via => :delete, :as => :user_delete
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
  resources:comments

  resource :user, controller: 'users' do
    collection do
      get 'change_password'
      patch 'update_password'
    end
  end
  #   # get '*path' => redirect('/')
  #   if Rails.env.development?
  #     get '404', to: 'application#page_not_found'
  #  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
