module Username
    module Model
        module Devise

            extend ActiveSupport::Concern

            included do
                attr_accessor :login
            end

            module ClassMethods
                def find_for_database_authentication warden_conditions
                    conditions = warden_conditions.dup
                    if login = conditions.delete(:login)
                        where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
                    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
                        where(conditions.to_h).first
                    end
                end
            end

        end
    end
end
