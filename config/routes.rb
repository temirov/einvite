EInvite::Application.routes.draw do

  resources :authorizations, only: [:new, :create, :edit, :update, :destroy]
  resources :users

  match '/login',  to: 'authorizations#new'
  match '/logout', to: 'authorizations#destroy', via: :delete

  root :to => 'users#index'
end
