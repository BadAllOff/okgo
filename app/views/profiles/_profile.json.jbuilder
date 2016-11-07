json.extract! profile, :id, :firstname, :lastname, :gender, :credo, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)