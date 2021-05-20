json.extract! user, :id, :email, :name, :created_at
json.confirmed user.confirmed?