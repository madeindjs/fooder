json.extract! user, :id, :username, :firstname, :lastname, :email, :created_at, :updated_at
json.url user_url(user, format: :json)