json.extract! menu, :id, :name, :description, :content, :tags, :price, :user_id, :restaurant_id, :created_at, :updated_at
json.url menu_url(menu, format: :json)