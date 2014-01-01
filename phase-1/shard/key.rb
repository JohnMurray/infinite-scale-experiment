module Shard

  # Represents a key for data stored in a sharded fashion.
  class Key
    def initialize(key)
      unless key.methods.include?(:<) and key.methods.include?(:>)
        raise MissingKeyMethods.new
      end

      @key = key
    end

    # Public: Given a Shard::KeyRange, determine if the key is within
    # the range.
    #
    # Returns boolean indicating inclusion in range
    def in?(range)
    end
  end


  class MissingKeyMethods < Exception
    def message
      "Key must support methods: '<' and '>'"
    end
  end

end

