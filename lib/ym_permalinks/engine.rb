module YmPermalinks
  class Engine < Rails::Engine
    config.app_middleware.insert_after(ActionDispatch::Head, PermalinksHandler)
  end
end
