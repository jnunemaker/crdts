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
end
