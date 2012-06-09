require 'crdts/integer'

describe Crdts::Integer do
  describe "#initialize" do
    it "defaults value to 0" do
      integer = Crdts::Integer.new
      integer.value.should be(0)
    end

    it "can initialize with different value" do
      integer = Crdts::Integer.new(5)
      integer.value.should be(5)
    end
  end

  describe "#increment" do
    it "returns self" do
      integer = Crdts::Integer.new(1)
      result = integer.increment
      result.should equal(integer)
    end

    context "with value" do
      it "increments by value" do
        integer = Crdts::Integer.new(1)
        integer.increment(3)
        integer.value.should be(4)
      end
    end

    context "without value" do
      it "increments by 1" do
        integer = Crdts::Integer.new(1)
        integer.increment
        integer.value.should be(2)
      end
    end
  end

  describe "#decrement" do
    it "returns self" do
      integer = Crdts::Integer.new(1)
      result = integer.decrement
      result.should equal(integer)
    end

    context "with value" do
      it "decrements by value" do
        integer = Crdts::Integer.new(5)
        integer.decrement(3)
        integer.value.should be(2)
      end
    end

    context "without value" do
      it "decrements by 1" do
        integer = Crdts::Integer.new(5)
        integer.decrement
        integer.value.should be(4)
      end
    end
  end

  describe "#clone" do
    before do
      @integer = Crdts::Integer.new(5)
      @clone = @integer.clone
    end

    it "returns new instance" do
      @clone.should_not equal(@integer)
    end

    it "sets value to the same" do
      @clone.value.should be(5)
    end
  end

  describe "#+" do
    before do
      @integer = Crdts::Integer.new(5)
      @result = @integer + Crdts::Integer.new(2)
    end

    it "returns new instance" do
      @result.should be_instance_of(Crdts::Integer)
      @result.should_not equal(@integer)
    end

    it "sets value to added values" do
      @result.value.should be(7)
    end

    context "with type that is not Crdts::Integer" do
      it "raises argument error" do
        expect { @integer + Object.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#-" do
    before do
      @integer = Crdts::Integer.new(5)
      @result = @integer - Crdts::Integer.new(2)
    end

    it "returns new instance" do
      @result.should be_instance_of(Crdts::Integer)
      @result.should_not equal(@integer)
    end

    it "sets value to subtracted values" do
      @result.value.should be(3)
    end

    context "with type that is not Crdts::Integer" do
      it "raises argument error" do
        expect { @integer - Object.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe "eql?" do
    it "returns true for same type and value" do
      integer = Crdts::Integer.new(5)
      integer.eql?(Crdts::Integer.new(5)).should be_true
    end

    it "returns false for same type, but different value" do
      integer = Crdts::Integer.new(5)
      integer.eql?(Crdts::Integer.new(3)).should be_false
    end

    it "returns false for different type" do
      integer = Crdts::Integer.new(5)
      integer.eql?(Object.new).should be_false
    end
  end

  describe "#==" do
    it "uses eql?" do
      integer = Crdts::Integer.new(5)
      integer.should_receive(:eql?)
      integer == Crdts::Integer.new(5)
    end
  end
end
