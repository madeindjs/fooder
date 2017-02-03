json.extract! resume, :id, :name, :user_id, :created_at, :updated_at
json.url resume_url(resume, format: :json)