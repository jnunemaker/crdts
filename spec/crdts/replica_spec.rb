require 'crdts/replica'

describe Crdts::Replica do
  it "initializes with name" do
    replica = Crdts::Replica.new('client-1')
    replica.should be_instance_of(Crdts::Replica)
  end

  it "has name" do
    replica = Crdts::Replica.new('client-1')
    replica.name.should eq('client-1')
  end

  describe "#eql?" do
    it "returns true when same class and name" do
      replica = Crdts::Replica.new('client-1')
      replica.should eql(Crdts::Replica.new('client-1'))
    end

    it "returns false when same class, but different name" do
      replica = Crdts::Replica.new('client-1')
      replica.should_not eql(Crdts::Replica.new('client-2'))
    end

    it "returns false when different class" do
      replica = Crdts::Replica.new('client-1')
      replica.should_not eql(Object.new)
    end
  end

  describe "#==" do
    it "returns true when same class and name" do
      replica = Crdts::Replica.new('client-1')
      replica.should eq(Crdts::Replica.new('client-1'))
    end

    it "returns false when same class, but different name" do
      replica = Crdts::Replica.new('client-1')
      replica.should_not eq(Crdts::Replica.new('client-2'))
    end

    it "returns false when different class" do
      replica = Crdts::Replica.new('client-1')
      replica.should_not eq(Object.new)
    end
  end
end
