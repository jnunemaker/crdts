require 'crdts/replica'
require 'crdts/integer'

module Crdts
  class ReplicatedInteger
    extend Forwardable

    def initialize(replica, integer = nil)
      @replica = replica
      @integer = integer || default_integer
    end

    def_delegators :@integer, :increment, :decrement, :+, :-

    private

    def default_integer
      Crdts::Integer.new
    end
  end
end
