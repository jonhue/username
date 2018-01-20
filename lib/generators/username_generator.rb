require 'rails/generators'
require 'rails/generators/migration'

class UsernameGenerator < Rails::Generators::Base

    include Rails::Generators::Migration

    source_root File.join File.dirname(__FILE__), 'templates'
    desc 'Install Username'

    def create_initializer
        template 'initializer.rb', 'config/initializers/username.rb'
    end

end
