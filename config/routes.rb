Rails.application.routes.draw do
  root "pages#show", page: "home"
  get "pages/:page", to: "pages#show", as: "page"
  devise_for :users, controllers: {
    registrations: "registrations"
  }

  resources :groups
end
