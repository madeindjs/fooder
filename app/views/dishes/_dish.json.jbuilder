json.extract! dish, :id, :name, :description, :category_id, :user_id, :restaurant_id, :created_at, :updated_at
json.url dish_url(dish, format: :json)