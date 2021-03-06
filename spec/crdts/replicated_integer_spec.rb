require 'crdts/replicated_integer'

describe Crdts::ReplicatedInteger do
  let(:replica) { double('replica') }
  let(:integer) { double('integer') }
  let(:replicated_integer) { Crdts::ReplicatedInteger.new(replica, integer) }

  it "initializes with replica" do
    replica = double('replica')
    replicated_integer = Crdts::ReplicatedInteger.new(replica)
    replicated_integer.should be_instance_of(Crdts::ReplicatedInteger)
  end

  it "initializes with replica and integer" do
    replica = double('replica')
    integer = double('integer')
    replicated_integer = Crdts::ReplicatedInteger.new(replica, integer)
    replicated_integer.should be_instance_of(Crdts::ReplicatedInteger)
  end

  it "delegates name to replica" do
    replica.should_receive(:name).and_return('client-1')
    replicated_integer.name.should eq('client-1')
  end

  it "delegates value to integer" do
    integer.should_receive(:value)
    replicated_integer.value
  end

  it "delegates increment to integer" do
    integer.should_receive(:increment)
    replicated_integer.increment
  end

  it "delegates decrement to integer" do
    integer.should_receive(:decrement)
    replicated_integer.decrement
  end

  it "delegates + to integer" do
    integer.should_receive(:+)
    replicated_integer.+
  end

  it "delegates - to integer" do
    integer.should_receive(:-)
    replicated_integer.-
  end

  describe "#eql?" do
    it "returns true when same class, replica and integer" do
      replicated_integer = Crdts::ReplicatedInteger.new(replica, integer)
      replicated_integer.should eql(Crdts::ReplicatedInteger.new(replica, integer))
    end

    it "returns false when same class, but different replica" do
      replicated_integer = Crdts::ReplicatedInteger.new(replica, integer)
      replicated_integer.should_not eql(Crdts::ReplicatedInteger.new(double('replica'), integer))
    end

    it "returns false when same class and replica, but different integer" do
      replicated_integer = Crdts::ReplicatedInteger.new(replica, integer)
      replicated_integer.should_not eql(Crdts::ReplicatedInteger.new(replica, double('integer')))
    end

    it "returns false when different class" do
      replicated_integer = Crdts::ReplicatedInteger.new(replica)
      replicated_integer.should_not eql(Object.new)
    end
  end

  describe "#==" do
    it "returns true when same class, replica and integer" do
      replicated_integer = Crdts::ReplicatedInteger.new(replica, integer)
      replicated_integer.should eq(Crdts::ReplicatedInteger.new(replica, integer))
    end

    it "returns false when same class, but different replica" do
      replicated_integer = Crdts::ReplicatedInteger.new(replica, integer)
      replicated_integer.should_not eq(Crdts::ReplicatedInteger.new(double('replica'), integer))
    end

    it "returns false when same class and replica, but different integer" do
      replicated_integer = Crdts::ReplicatedInteger.new(replica, integer)
      replicated_integer.should_not eq(Crdts::ReplicatedInteger.new(replica, double('integer')))
    end

    it "returns false when different class" do
      replicated_integer = Crdts::ReplicatedInteger.new(replica)
      replicated_integer.should_not eq(Object.new)
    end
  end
end
