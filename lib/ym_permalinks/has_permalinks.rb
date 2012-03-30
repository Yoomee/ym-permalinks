module YmPermalinks::HasPermalinks
  def has_permalinks
    class_eval do
      include YmPermalinks::Permalinkable
    end
  end
end