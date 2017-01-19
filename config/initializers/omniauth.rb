Rails.application.config.middleware.use(OmniAuth::Builder) do
  provider(
    :procore,
    ENV.fetch('PROCORE_CLIENT_ID'),
    ENV.fetch('PROCORE_CLIENT_SECRET'),
    client_options: { site: ENV['PROCORE_HOST'] },
  )
end
