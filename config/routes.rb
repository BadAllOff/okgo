Rails.application.routes.draw do

  devise_for :users
  resources :event_memberships
  resources :profiles, :languages, :events

  post 'event_memberships/join/:event_id' => 'event_memberships#join', as:   :join_event
  delete 'event_memberships/leave/:event_id' => 'event_memberships#leave', as: :leave_event
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'events#index'
end
