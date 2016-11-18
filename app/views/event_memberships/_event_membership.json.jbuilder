json.extract! event_membership, :id, :event_id, :user_id, :created_at, :updated_at
json.url event_membership_url(event_membership, format: :json)