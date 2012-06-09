require 'crdts/types'
require 'crdts/integer'
require 'crdts/replicated_integer_collection'

module Crdts

  # Public: A G-Counter is a grow-only counter (inspired by vector clocks)
  # in which only increment and merge are possible. Incrementing the counter
  # adds to the count for the replica provided.
  #
  # Examples
  #
  #   replica = Crdts::Replica.new('client-1')
  #   replicated_integer = Crdts::ReplicatedInteger.new(replica)
  #   collection = Crdts::ReplicatedIntegerCollection.new([replicated_integer])
  #
  #   counter = Crdts::GCounter.new(collection)
  #   counter.increment(replica)
  #   counter.value # => 1
  #   counter.increment(replica, 3)
  #   counter.value # 4
  #
  class GCounter

    attr_reader :collection

    # Public: initialize a new g counter
    #
    # collection - A ReplicatedIntegerCollection to operate on
    def initialize(collection = nil)
      @collection = collection || default_collection
    end

    def type
      Crdts::Types[:g_counter]
    end

    # Public: The sum of the replicated integers
    #
    # Returns the integer value of the counter
    def value
      @collection.sum
    end

    # Public: Increment the value for a given replica
    #
    # replica - The Replica to increment
    # increment_by - Integer amount to increment by (default: 1)
    def increment(replica, increment_by=1)
      replicated_integer = @collection.get(replica)
      replicated_integer.increment(increment_by)
      self
    end

    def each
      @collection.each do |item|
        yield item.name, item.value
      end
    end

    def eql?(other)
      self.class.eql?(other.class) && collection == other.collection
    end
    alias :== :eql?

    private

    def default_collection
      Crdts::ReplicatedIntegerCollection.new
    end
  end
end
