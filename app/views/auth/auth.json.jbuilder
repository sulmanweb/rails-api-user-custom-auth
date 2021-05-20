json.Authorization @token
json.user do
  json.partial! "users/self", user: @user
end