json.extract! payement, :id, :user_id, :transaction_id, :status, :created_at, :updated_at
json.url payement_url(payement, format: :json)