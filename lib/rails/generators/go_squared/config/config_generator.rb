require 'rails/generators/base'

module GoSquared
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      argument :site_token

      def copy_initializer_file
        @site_token = site_token
        template("go_squared.rb.erb", File.join("config/initializers/go_squared.rb"))
      end
    end
  end
end
