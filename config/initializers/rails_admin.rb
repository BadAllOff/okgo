RailsAdmin.config do |config|
  config.parent_controller = 'ApplicationController'
  config.total_columns_width = 1200

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    impersonate

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'Profile' do
    list do
      field :photo
      field :user
      include_all_fields
    end
  end

  config.model 'Event' do
    configure :starts_at, :date do
      # date_format :default
      strftime_format '%Y-%m-%d %H:%M'
    end

    configure :ends_at, :date do
      # date_format :default
      strftime_format '%Y-%m-%d %H:%M'
    end
  end

  config.model 'User' do
    list do
      field :id
      field :blocked do
        column_width 30
      end
      configure :profile_img do
        searchable [ :photo ]
        column_width 70
        pretty_value do
          bindings[:view].tag(:img, { :src => bindings[:object].profile.photo.url(:micro) })
        end
      end
      field :profile_img
      configure :firstname do
        searchable [ :firstname ]
        pretty_value do
          bindings[:object].profile.firstname
        end
      end
      field :firstname
      field :role
      field :email
      field :sign_in_count do
        column_width 50
      end
      field :last_sign_in_at
      field :events_count do
        column_width 50
      end
      field :event_memberships_count do
        column_width 50
      end
      field :comments_count do
        column_width 50
      end
      include_all_fields
    end
  end
end
