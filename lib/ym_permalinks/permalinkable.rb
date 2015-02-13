module YmPermalinks::Permalinkable
  def self.included(base)
    base.has_many :permalinks, :as => :resource, :autosave => true, :dependent => :destroy
    base.has_one :permalink, -> { where(:active => true) },:as => :resource, :autosave => true
    base.before_validation :set_permalink_path
    base.after_validation :set_permalink_errors
  end
  
  def permalink_path
    permalink.try(:path)
  end
  
  def permalink_path=(val)
    (self.permalink || self.build_permalink).path = val
  end
  
  private
  def set_permalink_errors
    permalink_errors = permalink.try(:errors).try(:get, :path)
    errors.add(:permalink_path, permalink_errors) if permalink_errors.present?
  end
  
  def set_permalink_path
    return true unless permalink
    if permalink.path.present?
      self.permalink.path = permalink.path.to_url
    else
      self.permalink.generate_unique_path!(to_s)
    end
  end
  
end