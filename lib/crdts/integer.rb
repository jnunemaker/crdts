module Crdts
  class Integer
    attr_reader :value

    def initialize(value=0)
      @value = value
    end

    def increment(increment_by=1)
      @value += increment_by
    end

    def decrement(decrement_by=1)
      @value -= decrement_by
    end

    def +(other)
      assert_valid_type(other)
      duplicate = clone
      duplicate.increment(other.value)
      duplicate
    end

    def -(other)
      assert_valid_type(other)
      duplicate = clone
      duplicate.decrement(other.value)
      duplicate
    end

    def eql?(other)
      self.class.eql?(other.class) && value == other.value
    end

    def ==(other)
      eql?(other)
    end

    private

    def assert_valid_type(other)
      raise ArgumentError, "must respond to value" unless other.respond_to?(:value)
    end
  end
end
