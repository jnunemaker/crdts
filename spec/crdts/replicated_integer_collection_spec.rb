require 'crdts/replicated_integer_collection'

describe Crdts::ReplicatedIntegerCollection do
  let(:replica) { double('replica') }
  let(:replicated_integer) { double('replicated integer', :replica => replica) }

  it "initializes with no arguments" do
    collection = Crdts::ReplicatedIntegerCollection.new
    collection.should be_instance_of(Crdts::ReplicatedIntegerCollection)
  end

  it "initializes with array of replicated integers" do
    collection = Crdts::ReplicatedIntegerCollection.new([replicated_integer])
    collection.should be_instance_of(Crdts::ReplicatedIntegerCollection)
  end

  describe "#get" do
    it "returns replicated integer instance" do
      collection = Crdts::ReplicatedIntegerCollection.new([replicated_integer])
      collection.get(replica).should equal(replicated_integer)
    end

    it "raises exception if replica not found" do
      collection = Crdts::ReplicatedIntegerCollection.new
      expect {
        puts collection.get(replica).inspect
      }.to raise_error(Crdts::ReplicaNotFound)
    end
  end

  describe "#sum" do
    it "returns sum of replicated integers" do
      collection = Crdts::ReplicatedIntegerCollection.new([
        double('replicated integer', :value => 3),
        double('replicated integer', :value => 8),
      ])
      collection.sum.should be(11)
    end
  end

  it "should be iterable" do
    expected = [
      double('replicated integer', :value => 3),
      double('replicated integer', :value => 8),
    ]
    actual = []

    collection = Crdts::ReplicatedIntegerCollection.new(expected)
    collection.each do |item|
      actual << item
    end
    actual.should eq(expected)
  end

  describe "#eql?" do
    it "returns true when same class and name" do
      collection = Crdts::ReplicatedIntegerCollection.new([replicated_integer])
      collection.should eql(Crdts::ReplicatedIntegerCollection.new([replicated_integer]))
    end

    it "returns false when same class, but different name" do
      collection = Crdts::ReplicatedIntegerCollection.new([replicated_integer])
      collection.should_not eql(Crdts::ReplicatedIntegerCollection.new)
    end

    it "returns false when different class" do
      collection = Crdts::ReplicatedIntegerCollection.new([replicated_integer])
      collection.should_not eql(Object.new)
    end
  end

  describe "#==" do
    it "returns true when same class and name" do
      collection = Crdts::ReplicatedIntegerCollection.new([replicated_integer])
      collection.should eq(Crdts::ReplicatedIntegerCollection.new([replicated_integer]))
    end

    it "returns false when same class, but different name" do
      collection = Crdts::ReplicatedIntegerCollection.new([replicated_integer])
      collection.should_not eq(Crdts::ReplicatedIntegerCollection.new)
    end

    it "returns false when different class" do
      collection = Crdts::ReplicatedIntegerCollection.new([replicated_integer])
      collection.should_not eq(Object.new)
    end
  end
end
