Rails.application.routes.draw do


  root                        'home#index'
  get      'signup'      =>   'users#new'
  get      'login'       =>   'sessions#new'
  post     'login'       =>   'sessions#create'
  delete   'logout'      =>   'sessions#destroy'

  # resources :users do
  #   resources :apps, only: [:new, :create, :destroy]
  # end

  resources :apps, only: [:new, :create, :destroy]
  resources :users, except: [:index, :destroy]


end
