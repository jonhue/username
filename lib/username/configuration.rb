module Username

    class << self
        attr_accessor :configuration
    end

    def self.configure
        self.configuration ||= Configuration.new
        yield configuration
    end

    class Configuration

        attr_accessor :models
        attr_accessor :forbidden
        attr_accessor :minlength
        attr_accessor :maxlength
        attr_accessor :regex
        attr_accessor :global_uniqueness

        def initialize
            @models = []
            @forbidden = []
            @minlength = 1
            @maxlength = 20
            @regex = /\A[a-zA-Z0-9_\.]*\z/
            @global_uniqueness = true
        end

    end
end
