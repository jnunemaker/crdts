require 'crdts/integer'
require 'crdts/replicated_integer_collection'

module Crdts
  class GCounter
    def initialize(collection = nil)
      @collection = collection || default_collection
    end

    def value
      @collection.sum
    end

    def increment(replica, increment_by=1)
      replicated_integer = @collection.get(replica)
      replicated_integer.increment(increment_by)
      self
    end

    private

    def default_collection
      Crdts::ReplicatedIntegerCollection.new
    end
  end
end
