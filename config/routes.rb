Rails.application.routes.draw do

  resources :languages
  resources :profiles
  devise_for :users
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'events#index'
end
