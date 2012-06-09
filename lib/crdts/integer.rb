module Crdts
  class Integer
    attr_reader :value

    def initialize(value=0)
      @value = value
    end

    def increment(increment_by=1)
      @value += increment_by
      self
    end

    def decrement(decrement_by=1)
      @value -= decrement_by
      self
    end

    def +(other)
      assert_valid_type(other)
      clone.increment(other.value)
    end

    def -(other)
      assert_valid_type(other)
      clone.decrement(other.value)
    end

    def eql?(other)
      self.class.eql?(other.class) && value == other.value
    end
    alias :== :eql?

    private

    def assert_valid_type(other)
      raise ArgumentError, "must respond to value" unless other.respond_to?(:value)
    end
  end
end
