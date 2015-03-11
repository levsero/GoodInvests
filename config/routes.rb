Rails.application.routes.draw do
  root to: 'static_pages#root'

  resources :users
  resource :session, only: [:create, :destroy, :new]

  namespace :api, defaults: {format: :json} do
    resources :companies, only: [:index, :show]
    resources :users
    resources :comments, only: [:create, :destroy, :update]
  end
end
