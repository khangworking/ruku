json.extract! room, :id, :name, :is_privite, :password, :created_at, :updated_at
json.url room_url(room, format: :json)
