Rails.application.routes.draw do
  
  namespace :dashboard do
    get 'dashboard/index'
  end
  devise_for :users
  get 'dashboard/index'
  root to: "pages#index"

  namespace :dashboard do
    root to: "dashboard#index"
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
                                        