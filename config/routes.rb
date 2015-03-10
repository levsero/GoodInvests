Rails.application.routes.draw do
  root to: 'users#index'

  resources :users
  resource :session, only: [:create, :destroy, :new]

  namespace :api, defaults: {format: :json} do
    resources :users, except: [:new]
    resources :companies, only: [:index, :show]
  end
end
