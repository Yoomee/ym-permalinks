class PermalinksHandler
  
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    if headers['X-Cascade'] == 'pass'
      path_info = (env['PATH_INFO'] || env['REQUEST_URI'] || env['REQUEST_PATH'])
      without_params = path_info.split(/\?/).first
      path = without_params.split(/\//).reject(&:blank?).first
      if permalink = Permalink.find_by_path(path)
        new_path = without_params.sub("/#{path}",permalink.resource_path)
        env['PATH_INFO'] = env['REQUEST_URI'] = env['REQUEST_PATH'] = new_path
        env['ORIGINAL_PATH_INFO'] = path_info
        return @app.call(env)
      end
    end
    [status, headers, body]
  end
  
end
