module Crdts
  class Replica
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def eql?(other)
      self.class.eql?(other.class) && name == other.name
    end
    alias :== :eql?
  end
end
