require 'api_constraints'

Rails.application.routes.draw do

  mount Knock::Engine => "/knock"

  root                        'home#index'
  get      'signup'      =>   'users#new'
  get      'login'       =>   'sessions#new'
  post     'login'       =>   'sessions#create'
  delete   'logout'      =>   'sessions#destroy'

  resources :apps, only: [:new, :create, :destroy]
  resources :users, except: [:index, :destroy]

  namespace :api, defaults: { format: :json } do
                            #constraints: { subdomain: 'api' }, path: '/'
    scope module: :v1,
            constraints: ApiConstraints.new(version: 1, default: true) do
      resources :pubs, only: [:show, :create, :update, :destroy, :index]
    end
  end
end
