json.extract! restaurant, :id, :name, :address, :zip_code, :city, :user_id, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)