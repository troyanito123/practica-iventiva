Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'
  root 'articles#index'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'
  get 'users', to: 'users#index'
  delete 'users/:id', to: 'users#destroy', as: 'user_delete'

  get 'profile/:id/edit', to: 'users#edit', as: 'edit_user'
  put 'profile/:id', to: 'users#update', as: 'user'

  get 'home', to: 'home#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :articles do
    resources :comments
  end

  resources :password_resets,     only: [:new, :create, :edit, :update]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
