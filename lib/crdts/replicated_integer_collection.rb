require 'crdts/replicated_integer'

module Crdts
  class ReplicaNotFound < StandardError
    def initialize(replica)
      super "Could not find replica #{replica.inspect}"
    end
  end

  class ReplicatedIntegerCollection
    include Enumerable

    attr_reader :source

    def initialize(source = nil)
      @source = source || default_source
    end

    def get(replica)
      replicated_integer = @source.detect { |item| item.replica == replica }
      replicated_integer || raise(ReplicaNotFound.new(replica))
    end

    def sum
      @source.inject(0) { |sum, item| sum += item.value }
    end

    def each
      @source.each { |item| yield item }
    end

    def eql?(other)
      self.class.eql?(other.class) && source == other.source
    end
    alias :== :eql?

    private

    def default_source
      []
    end
  end
end
