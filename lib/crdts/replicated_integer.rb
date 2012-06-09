require 'crdts/replica'
require 'crdts/integer'

module Crdts
  class ReplicatedInteger
    extend Forwardable

    attr_reader :replica, :integer

    def initialize(replica, integer = nil)
      @replica = replica
      @integer = integer || default_integer
    end

    def_delegator :@replica, :name
    def_delegators :@integer, :value, :increment, :decrement, :+, :-

    def eql?(other)
      self.class.eql?(other.class) &&
        replica == other.replica &&
        integer == other.integer
    end
    alias :== :eql?

    private

    def default_integer
      Crdts::Integer.new
    end
  end
end
