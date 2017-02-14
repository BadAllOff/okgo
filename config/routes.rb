Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, skip: [:session, :password, :registration], controllers: { omniauth_callbacks: "omniauth_callbacks" }
  devise_scope :user do
    get   '/users/auth/failure'   => 'omniauth_callbacks#failure'
    post  '/finish_registration'  => 'omniauth_callbacks#finish_registration'
    get   '/finish_registration'  => 'events#index'
  end
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    devise_for :users, skip: [:registrations, :omniauth_callbacks]
    devise_scope :user do
      resource :registration,
               only: [:new, :create, :edit, :update],
               path: 'users',
               path_names: { new: 'sign_up' },
               controller: 'devise/registrations',
               as: :user_registration do
        get :cancel
      end
    end

    resources :feedbacks do
      post 'like', to: 'socializations#like'
      delete 'unlike', to: 'socializations#unlike'
      resources :comments, module: :feedbacks
    end
    resources :activities
    resources :profiles, :languages
    resources :events do
      member do
        post 'members', to: 'events#members'
      end
      post 'like', to: 'socializations#like'
      delete 'unlike', to: 'socializations#unlike'
      resources :comments, module: :events
    end
    resources :event_memberships do
      collection do
        get 'as_tutor'
        get 'as_member'
        get 'show_event_members/:event_id' => 'event_memberships#show_event_members', as: :show_members
      end

      member do
        post 'member_attended' => 'event_memberships#member_attended', as: :member_attended
        post 'member_not_attended' => 'event_memberships#member_not_attended', as: :member_not_attended
        post 'rate_member' => 'event_memberships#rate_member', as: :rate
      end
    end
    post 'event_memberships/join/:event_id' => 'event_memberships#join', as:   :join_event
    delete 'event_memberships/leave/:event_id' => 'event_memberships#leave', as: :leave_event
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'events#index'
  end
end
