Rails.application.routes.draw do
  root to: 'static_pages#root'

  namespace :api, defaults: {format: :json} do
    resources :companies, only: [:index, :show]
    resources :users
    resources :comments, only: [:create, :destroy, :update]
    resource :session, only: [:create, :destroy]
    resources :follows, only: [:create]
    resources :ratings, only: [:create]

    delete "follows/:id/:followable_id/:followable_type", to: "follows#destroy"
    get 'logged_in', :to => 'users#logged_in'
    get "/search", to: "searches#search"
    get 'most_followed', :to => 'companies#most_followed'
  end
end
