EInvite::Application.routes.draw do
  
  resources :authorizations
  resources :users

  resources :sessions, only: [:new, :create, :destroy]

  match '/register',  to: 'users#new'
  match '/login',  to: 'sessions#new'
  match '/logout', to: 'sessions#destroy', via: :delete

  root :to => 'users#index'
end
