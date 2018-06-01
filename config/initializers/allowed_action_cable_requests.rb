if Rails.env.development?
  Rails.application.config.action_cable.allowed_request_origins = [nil, /http:\/\/*/, /https:\/\/*/]
end
