Rails.application.routes.draw do
  
  devise_for :users
  # devise_for :managers
  # devise_for :client
  # devise_for :admins

  namespace :dashboard do
    get 'dashboard/index'
  end
  get 'dashboard/index'
  root to: "pages#index"

  namespace :dashboard do
    root to: "dashboard#index"
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
                                        