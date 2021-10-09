Rails.application.config.middleware.use OmniAuth::Builder do

  provider :google_oauth2, ENV['client_id'],
                           ENV['client_secret'],
                           image_size: 150
end

OmniAuth.config.allowed_request_methods = [:post, :get]