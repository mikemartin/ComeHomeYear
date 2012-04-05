Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['COME_HOME_FACEBOOK_KEY'], ENV['COME_HOME_FACEBOOK_SECRET'],
    :client_options => {:ssl => {:ca_path => '/etc/ssl/certs', :ca_file => '/etc/ssl/certs/ca-certificates.crt'}}
    
  provider :identity, :fields => [:email],
    :on_failed_registration => lambda { |env| IdentitiesController.action(:new).call(env) }
end