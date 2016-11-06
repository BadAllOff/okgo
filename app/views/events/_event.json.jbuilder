json.extract! event, :id, :title, :description, :address, :starts_at, :ends_at, :created_at, :updated_at
json.url event_url(event, format: :json)