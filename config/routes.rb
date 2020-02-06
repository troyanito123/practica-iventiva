Rails.application.routes.draw do
  get 'register', to: 'users#new'
  post 'register', to: 'users#create'
  get 'home', to: 'home#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
