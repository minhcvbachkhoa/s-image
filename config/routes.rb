Rails.application.routes.draw do
  root "pages#show", page: "home"
  get "pages/:page", to: "pages#show", as: "page"
  devise_for :users, controllers: {
    registrations: "registrations"
  }

  resources :groups
  resources :users, except: [:new, :create] do
    resources :relationships, only: [:create, :destroy]
  end
  resources :relationships, only: :index
  resources :images do
    resources :comments, except: :show
  end
  resources :albums
  resources :comments, only: :index
end
