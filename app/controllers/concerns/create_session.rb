module CreateSession
  extend ActiveSupport::Concern
  require 'json_web_token'

  def jwt_session_create user_id
    user = User.find_by(id: user_id)
    session = user.sessions.build
    if user && session.save
      return JsonWebToken.encode({user_id: user_id, token: session.token})
    else
      return nil
    end
  end
end