require 'crdts/g_counter'
require 'crdts/converters/hash'

describe Crdts::Converters::Hash do
  let(:converter) { Crdts::Converters::Hash.new }

  describe "#dump" do
    it "returns hash" do
      replica1 = Crdts::Replica.new('client-1')
      replica2 = Crdts::Replica.new('client-2')

      replicated_integer1 = Crdts::ReplicatedInteger.new(replica1, Crdts::Integer.new(12))
      replicated_integer2 = Crdts::ReplicatedInteger.new(replica2, Crdts::Integer.new(7))

      collection = Crdts::ReplicatedIntegerCollection.new([
        replicated_integer1,
        replicated_integer2,
      ])

      counter = Crdts::GCounter.new(collection)

      result = converter.dump(counter)
      result.should eq({
        :type => 1,
        :element => {
          'client-1' => 12,
          'client-2' => 7,
        }
      })
    end
  end

  describe "#load" do
    it "returns g counter instance" do
      replica1 = Crdts::Replica.new('client-1')
      replica2 = Crdts::Replica.new('client-2')

      replicated_integer1 = Crdts::ReplicatedInteger.new(replica1, Crdts::Integer.new(12))
      replicated_integer2 = Crdts::ReplicatedInteger.new(replica2, Crdts::Integer.new(7))

      collection = Crdts::ReplicatedIntegerCollection.new([
        replicated_integer1,
        replicated_integer2,
      ])

      counter = Crdts::GCounter.new(collection)

      hash = {
        :type => 1,
        :element => {
          'client-1' => 12,
          'client-2' => 7,
        }
      }

      result = converter.load(hash)
      result.should be_instance_of(Crdts::GCounter)
      result.should eq(counter)
    end

    it "raises exception if missing required key" do
      expect { converter.load({}) }.to raise_error(ArgumentError)
    end
  end
end
