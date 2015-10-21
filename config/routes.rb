Rails.application.routes.draw do

  resources :wikis

  devise_for :users
  
  get 'home/index'

  root to: 'home#index'

end
