class PermalinksHandler
  
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    if headers['X-Cascade'] == 'pass'
      path_info = (env['PATH_INFO'] || env['REQUEST_URI'] || env['REQUEST_PATH'])
      if path_info.match(/^\/[^\/]+$/)
        path = path_info.sub(/^\//, '').split(/\?/).first
        if permalink = Permalink.find_by_path(path)
          env['PATH_INFO'] = env['REQUEST_URI'] = env['REQUEST_PATH'] = permalink.resource_path
          env['ORIGINAL_PATH_INFO'] = path_info
          return @app.call(env)
        end
      end
    end
    [status, headers, body]
  end
  
end
