module YmPermalinks
  module Permalinkable
    def has_permalinks
      class_eval do
        has_many :permalinks, :as => :resource, :autosave => true, :dependent => :destroy
        has_one :permalink, :as => :resource, :conditions => {:active => true}
      end
    end
  end
end