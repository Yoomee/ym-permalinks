module ActionDispatch
  module Routing
    module UrlFor
      def url_for_with_permalinks(options = nil)
        case options
        when nil, String
          url_for_without_permalinks(options)
        when Hash
          if options[:action] == "show" && permalink = extract_permalink(options)
            anchor = "##{options.delete(:anchor)}"
            query_string = "?#{options.except(:_positional_keys, :_positional_args, :action, :routing_type, :controller, :use_route, :only_path).to_query}"
            "/#{permalink.path}#{query_string unless query_string == "?"}#{anchor unless anchor == "#"}"
          else
            url_for_without_permalinks(options)
          end
        else
          if options.respond_to?(:permalink) && permalink = options.permalink
            "/#{permalink.path}"
          else
            url_for_without_permalinks(options)
          end
        end
      end
      alias_method_chain :url_for, :permalinks
      
      private
      def extract_permalink(options)
        if options[:_positional_args] && options[:_positional_args].size == 1
          resource = options[:_positional_args].first
          if resource.respond_to?(:permalink) && resource.permalink
            resource.permalink
          else
            nil
          end
        end
      end
    end
  end
end