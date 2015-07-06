Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  devise_for :users, controllers: { registrations: "users/registrations" }

  get ":user_id", to: "users#show", as: :user

  scope ":user_id", as: :user do
    get "stories", to: "users#stories", as: "stories"
    get "stories_of", to: "users#stories_of", as: "stories_of"
    resources :following, only: [:index, :create, :destroy], as: "followings", controller: "users/followings"
    resources :followers, only: [:index], controller: "users/followers"
    resources :likes, only: [:index, :create, :destroy], controller: "users/likes"
  end

  resources :stories, only: [:index, :create, :destroy]
end
