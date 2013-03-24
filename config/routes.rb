EInvite::Application.routes.draw do
  get "site/index"

  resources :authorizations, only: [:new, :create, :edit, :update, :destroy]
  
  shallow do
    resources :users do 
      resources :competitions
    end
  end

  match '/login',  to: 'authorizations#new'
  match '/logout', to: 'authorizations#destroy', via: :delete

  root :to => 'site#index'
end
