module AuthenticationsHelper
  def authenticated?
    !!session[:user_id]
  end
end