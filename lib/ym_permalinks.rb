require 'stringex'
require 'ym_core'
require "ym_permalinks/permalinks_handler"
require "ym_permalinks/engine"

module YmPermalinks
end

require "ym_permalinks/has_permalinks"
require "ym_permalinks/permalinkable"
ActiveRecord::Base.extend YmPermalinks::HasPermalinks

Dir[File.dirname(__FILE__) + '/ym_permalinks/controllers/*.rb'].each {|file| require file }