module Username
    module Model

        extend ActiveSupport::Concern

        module ClassMethods
            def has_username options = {}
                defaults = {
                    devise: false
                }
                options = defaults.merge options

                Username.configuration&.models << self.name
                validate :username_validation

                if options[:devise]
                    attr_accessor :login
                    extend Username::Model::DeviseMethods
                end
            end

            def username_valid? username
                unless username.nil?
                    valid = true
                    if Username.configuration.global_uniqueness
                        Username.configuration.models.each do |model|
                            valid = false if model.constantize.all.where(username: username).any?
                        end
                    else
                        valid = false if self.all.where(username: username).any?
                    end
                    valid = false if Username.configuration.forbidden.include?(username) || username.length < Username.configuration.minlength || username.length > Username.configuration.maxlength || username !~ Username.configuration.regex
                    valid
                else
                    true
                end
            end
        end

        module DeviseMethods
            def find_for_database_authentication warden_conditions
                conditions = warden_conditions.dup
                if login = conditions.delete(:login)
                    where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
                elsif conditions.has_key?(:username) || conditions.has_key?(:email)
                    where(conditions.to_h).first
                end
            end
        end

        def username_available? username
            unless username.nil?
                valid = true
                if Username.configuration.global_uniqueness
                    Username.configuration.models.each do |model|
                        if model == self.class.name
                            valid = false if model.constantize.all.where(username: username).where.not(id: id).any?
                        else
                            valid = false if model.constantize.all.where(username: username).any?
                        end
                    end
                else
                    valid = false if self.class.all.where(username: username).where.not(id: id).any?
                end
                valid = false if Username.configuration.forbidden.include?(username) || username.length < Username.configuration.minlength || username.length > Username.configuration.maxlength || username !~ Username.configuration.regex
                valid
            else
                true
            end
        end

        private

        def username_validation
            errors.add(:username, 'has already been taken') unless self.username_available? self.username
        end

    end
end
