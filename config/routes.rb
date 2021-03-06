Rails.application.routes.draw do
  root "pages#show", page: "home"
  get "pages/:page", to: "pages#show", as: "page"
  devise_for :users, controllers: {
    registrations: "registrations"
  }

  resources :groups
  resources :users, except: [:new, :create] do
    resources :relationships, only: [:create, :destroy]
    resources :bookmarks, only: :index
    resources :albums, only: :index
    resources :groups, only: :index
  end
  resources :relationships, only: :index
  resources :images do
    resources :comments, except: :show
    resources :bookmarks, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  resources :albums, except: :index
  resources :comments do
    resources :likes, only: [:create, :destroy]
  end
end
