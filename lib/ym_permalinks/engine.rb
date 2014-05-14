module YmPermalinks
  class Engine < Rails::Engine
    config.app_middleware.insert_after(Rack::Head, PermalinksHandler)
  end
end
