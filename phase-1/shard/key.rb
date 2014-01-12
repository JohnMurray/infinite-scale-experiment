module Shard

  # Represents a key for data stored in a sharded fashion.
  class Key

    REQUIRED_METHODS = [:<=, :>=].sort

    # Ensure that the correct properties exist on our keys so that
    # we can ensure everything works as planned. (yes I know this is
    # probably not entirely Ruby'ish, but it makes me feel all safe
    # inside, type-safe that is).
    def initialize(key)
      unless (key.methods & REQUIRED_METHODS).sort == REQUIRED_METHODS
        raise MissingKeyMethods.new
      end

      @key = key
    end

    # Public: Given a Shard::KeyRange, determine if the key is within
    # the range.
    #
    # Returns boolean indicating inclusion in range
    def in?(range)
      @key <= range.end and @key >= range.start
    end
  end


  class MissingKeyMethods < Exception
    def message
      "Key must support methods: '<=' and '>='"
    end
  end

end

