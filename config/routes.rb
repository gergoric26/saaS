Rails.application.routes.draw do

  resources :wikis

  devise_for :users

  resources :charges, only: [:new, :create]
  
  get 'home/index'

  root to: 'home#index'

end
