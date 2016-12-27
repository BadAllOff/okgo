Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    devise_for :users
    resources :activities
    resources :profiles, :languages
    resources :events do
      post 'like', to: 'socializations#like'
      delete 'unlike', to: 'socializations#unlike'
    end
    resources :event_memberships do
      collection do
        get 'as_tutor'
        get 'as_member'

      end

      member do
        post 'member_attended' => 'event_memberships#member_attended', as: :member_attended
        post 'member_not_attended' => 'event_memberships#member_not_attended', as: :member_not_attended
      end
    end
    post 'event_memberships/join/:event_id' => 'event_memberships#join', as:   :join_event
    delete 'event_memberships/leave/:event_id' => 'event_memberships#leave', as: :leave_event
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'events#index'
  end
end
