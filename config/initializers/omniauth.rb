Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['COMING_HOME_FACEBOOK_KEY'], ENV['COMING_HOME_FACEBOOK_SECRET']
  provider :identity, :fields => [:email],
    :on_failed_registration => lambda { |env| IdentitiesController.action(:new).call(env) }
end