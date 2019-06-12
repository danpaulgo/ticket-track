Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#home'
  get 'about', to: 'application#about'
  get 'contact', to: 'application#contact'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users do
  	resources :transactions
    resources :events, only: [:index, :show] do
      resources :transactions, only: [:index]
    end
  end
  resources :performers, except: [:new, :create] do
    resources :events, only: [:index]
  end
  resources :venues do
    resources :events, only: [:index]
  end
  resources :events
  resources :transactions
  resources :transaction_sources, except: [:new, :create, :show]
  resources :account_activations, only: [:edit]
  


end
