require 'stringex'
require "ym_permalinks/permalinks_handler"
require "ym_permalinks/engine"

module YmPermalinks
end

require "ym_permalinks/permalinkable"
ActiveRecord::Base.extend YmPermalinks::Permalinkable

Dir[File.dirname(__FILE__) + '/ym_tags/models/*.rb'].each {|file| require file }