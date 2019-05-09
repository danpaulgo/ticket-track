Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#home'
  get 'about', to: 'application#about'
  get 'contact', to: 'application#contact'

  resources :users do
  	resources :transactions, except: :show
    resources :events, only: [:index, :show]
  end
  resources :performers, except: [:new, :create]
  resources :venues
  resources :events
  resources :transactions, except: :show
  resources :transaction_sources, except: [:new, :create, :show]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
