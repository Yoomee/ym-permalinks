module YmPermalinks::PermalinkableController
  def self.included(base)
    base.before_filter :redirect_to_permalink, :only => :show
  end
  
  private
  def redirect_to_permalink
    return true if env['ORIGINAL_PATH_INFO'].present?
    permalink_path = send(controller_name.singularize).permalink.try(:path)
    redirect_to ["/#{permalink_path}",request.query_string].compact.join('?') if permalink_path
  end
end