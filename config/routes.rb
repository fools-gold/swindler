Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :users, only: []

  get ":id", to: "users#show", as: :user

  scope ":user_id", as: :user do
    resources :following, only: [:index], as: "followings", controller: "users/followings"
    resources :followers, only: [:index], controller: "users/followers"
  end
end
