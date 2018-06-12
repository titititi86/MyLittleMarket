json.extract! contact, :id, :subject, :content, :user_id, :created_at, :updated_at
json.url contact_url(contact, format: :json)