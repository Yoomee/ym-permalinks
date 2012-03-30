module YmPermalinks::Permalinkable
  def self.included(base)
    base.has_many :permalinks, :as => :resource, :autosave => true, :dependent => :destroy
    base.has_one :permalink, :as => :resource, :conditions => {:active => true}
    base.accepts_nested_attributes_for :permalink
    base.before_validation :set_permalink_path
    base.alias_method_chain :permalink, :build
  end
  
  def permalink_with_build
    permalink_without_build || self.build_permalink
  end
  
  private
  def set_permalink_path
    return true unless permalink
    if permalink.path.present?
      self.permalink.path = permalink.path.to_url
    else
      self.permalink.generate_unique_path!(to_s)
    end
  end
end