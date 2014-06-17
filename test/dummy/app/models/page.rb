class Page < ActiveRecord::Base

  has_permalinks

  def to_s
    title
  end

end
