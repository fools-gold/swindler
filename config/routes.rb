Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: []

  get ":id", to: "users#show", as: :user
end
