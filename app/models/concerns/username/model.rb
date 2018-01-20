module Username
    module Model

        extend ActiveSupport::Concern

        module ClassMethods
            def has_username
                Username.configuration&.models << self.name
                validate :username_validation
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
