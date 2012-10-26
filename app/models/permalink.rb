class Permalink < ActiveRecord::Base
  
  belongs_to :resource, :polymorphic => true

  validates :path, :presence => true, :uniqueness => {:case_sensitive => false, :unless => :old_exists?}
  #validates :resource, :presence => true

  validate  :path_does_not_match_existing_route
  validate  :path_is_valid_url
  
  after_update :handle_old_permalinks
  
  def initialize(*args)
    super(*args)
    generate_unique_path!
  end
  
  def generate_unique_path!(title = resource.to_s)
    if path.blank? && title.present?
      path_name_root = title.to_url.parameterize
      unique_path_name = path_name_root.dup
      permalinks = new_record? ? self.class : self.class.where("id != ?",self.id)
      count = 0
      while permalinks.exists?(:path => unique_path_name)
        count += 1
        unique_path_name = "#{path_name_root}-#{count}"
      end    
      self.path = unique_path_name
    end
  end
  
  def resource_path
    "/#{resource_type.tableize}/#{resource_id}"
  end

  private
  def handle_old_permalinks
    old_versions.destroy_all if old_versions.present?
    Permalink.create(:path => path_was, :resource => resource, :active => false)
  end

  def old_exists?
    old_versions.present?
  end

  def old_versions
    return [] if resource.nil?
    Permalink.where(:resource_id => resource.id, :resource_type => resource.class.to_s, :path => path).where(["id <> ?", id])
  end
  
  def path_does_not_match_existing_route
    existing_routes = Rails.application.routes.routes.collect do |route|
      route.path.split(/\/|\(/).try(:[],1)
    end.uniq.compact
    if existing_routes.include?(path)
      errors.add(:path, "has already been taken")
    end
  end
  
  def path_is_valid_url
    if path.present? && (path != path.to_url.parameterize)
      errors.add(:path, "is invalid")
    end
  end

end
