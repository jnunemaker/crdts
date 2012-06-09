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
      @collection[replica].increment(increment_by)
    end

    private

    def default_collection
      Crdts::ReplicatedIntegerCollection.new
    end
  end
end
