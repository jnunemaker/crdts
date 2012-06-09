require 'crdts/integer'
require 'crdts/replica'

module Crdts
  class ReplicatedIntegerCollection
    def initialize(hash = nil)
      @source = Hash.new { |hash, key|
        replica = Replica.new(key)
        integer = Crdts::Integer.new
        hash[replica] = integer
      }
      @source.update(hash) unless hash.nil?
    end

    def [](replica)
      @source[replica]
    end

    def sum
      @source.values.inject(0) { |sum, integer| sum += integer.value }
    end
  end
end
