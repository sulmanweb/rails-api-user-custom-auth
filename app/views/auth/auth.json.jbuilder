json.Authorization "Bearer #{@token}"
json.user do
  json.partial! "users/self", user: @user
end