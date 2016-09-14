require 'rails/generators/base'

module Gosquared
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      argument :site_token

      def copy_initializer_file
        @site_token = site_token
        template("gosquared.rb.erb", File.join("config/initializers/gosquared.rb"))
      end
    end
  end
end
