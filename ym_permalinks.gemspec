$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ym_permalinks/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ym_permalinks"
  s.version     = YmPermalinks::VERSION
  s.authors     = ["Matt Atkins", "Ian Mooney", "Si Wilkins", "Edward Andrews"]
  s.email       = ["matt@yoomee.com", "ian@yoomee.com", "si@yoomee.com", "edward@yoomee.com"]
  s.homepage    = "http://www.yoomee.com"
  s.summary     = "Summary of YmPermalinks."
  s.description = "Description of YmPermalinks."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'ym_core' , "~> 1.0"
  s.add_dependency "stringex", "~>1.3.2"

  # for testing
  s.add_development_dependency "mysql2"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency "capybara"
  s.add_development_dependency "capybara-webkit"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "ym_tools"#, '~> 0.1.13'
  s.add_development_dependency "geminabox"

end
