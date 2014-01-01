module Shard

  # Represents a range of keys used for sharded data. A KeyRange
  # represents a specified 'partition'
  class KeyRange
    attr_reader :start, :end

    def initialize(start, finish)
      @start = start
      @end   = finish
    end

    # Public: Determines if a Key is within this rage.
    #
    # Returns boolean indicating inclusion of key in range
    def include?(key)
      key.in? self
    end

  end

end
