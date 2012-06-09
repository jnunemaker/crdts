require 'crdts/replicated_integer_collection'

describe Crdts::ReplicatedIntegerCollection do
  let(:replica) { Crdts::Replica.new('client-1') }
  let(:integer) { Crdts::Integer.new }

  it "initializes with no arguments" do
    collection = Crdts::ReplicatedIntegerCollection.new
    collection.should be_instance_of(Crdts::ReplicatedIntegerCollection)
  end

  it "initializes with hash of replica/integer pairs" do
    hash = {replica => integer}
    collection = Crdts::ReplicatedIntegerCollection.new(hash)
    collection.should be_instance_of(Crdts::ReplicatedIntegerCollection)
  end

  describe "#[]" do
    context "with known replica" do
      it "returns integer instance" do
        collection = Crdts::ReplicatedIntegerCollection.new({replica => integer})
        collection[replica].should equal(integer)
      end
    end

    context "with missing replica" do
      it "returns integer instance" do
        collection = Crdts::ReplicatedIntegerCollection.new
        result = collection[replica]
        result.should be_instance_of(Crdts::Integer)
        result.value.should be(0)
      end
    end
  end

  describe "#sum" do
    it "returns sum of replicated integers" do
      collection = Crdts::ReplicatedIntegerCollection.new({
        Crdts::Replica.new('client-1') => Crdts::Integer.new(3),
        Crdts::Replica.new('client-2') => Crdts::Integer.new(8),
      })
      collection.sum.should be(11)
    end
  end
end
