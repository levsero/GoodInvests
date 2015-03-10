Rails.application.routes.draw do
  root to: 'users#index'

  resources :users
  resource :session, only: [:create, :destroy, :new]
end
