require 'rails/railtie'

module Username
    class Railtie < Rails::Railtie

        initializer 'username.initialize' do
            ActiveSupport.on_load :active_record do
                include Username::Model
            end
        end

    end
end
