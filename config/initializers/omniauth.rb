OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '461347917304117', '40ba5cf76c0ef5254b307726fc214b8d'
end