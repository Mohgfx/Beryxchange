# encoding: UTF-8
# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  case ENV['OAUTH2_SIGN_IN_PROVIDER']
    when 'auth0'
      require 'omniauth-auth0'
      provider :auth0,
               ENV.fetch('AUTH0_OAUTH2_CLIENT_ID'),
               ENV.fetch('AUTH0_OAUTH2_CLIENT_SECRET'),
               ENV.fetch('AUTH0_OAUTH2_DOMAIN'),
               { authorize_params: {
                   scope: ENV.fetch('AUTH0_OAUTH2_SCOPE', 'openid profile email'),
                 redirect_uri: ENV.fetch('AUTH0_OAUTH2_REDIRECT_URL')
                 }
               }
    when 'google'
      require 'omniauth-google-oauth2'
      provider :google_oauth2, ENV.fetch('GOOGLE_CLIENT_ID'), ENV.fetch('GOOGLE_CLIENT_SECRET'), redirect_uri: ENV.fetch('GOOGLE_OAUTH2_REDIRECT_URL')

    when 'barong'
      require 'omniauth-barong'
      provider :barong,
               ENV.fetch('BARONG_CLIENT_ID'),
               ENV.fetch('BARONG_CLIENT_SECRET'),
               domain: ENV.fetch('BARONG_DOMAIN'),
               redirect_uri: ENV.fetch('BARONG_OAUTH2_REDIRECT_URL')
  end
end

OmniAuth.config.on_failure = lambda do |env|
  SessionsController.action(:failure).call(env)
end

OmniAuth.config.logger = Rails.logger
