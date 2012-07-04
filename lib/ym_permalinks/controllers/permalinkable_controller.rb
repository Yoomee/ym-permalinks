module YmPermalinks::PermalinkableController
  def self.included(base)
    base.before_filter :redirect_to_permalink, :only => :show
  end
  
  private
  def redirect_to_permalink
    return true if env['ORIGINAL_PATH_INFO'].present?
    instance_var = instance_variable_get("@#{controller_name.singularize}") || send(controller_name.singularize)
    permalink_path = instance_var.permalink.try(:path)
    redirect_to ["/#{permalink_path}",request.query_string].select(&:present?).join('?') if permalink_path
  end
end