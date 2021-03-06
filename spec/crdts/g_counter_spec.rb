require 'crdts/g_counter'

describe Crdts::GCounter do
  it "initializes with no arguments" do
    counter = Crdts::GCounter.new
    counter.should be_instance_of(Crdts::GCounter)
  end

  it "initializes with collection" do
    collection = double('collection')
    counter = Crdts::GCounter.new(collection)
    counter.should be_instance_of(Crdts::GCounter)
  end

  it "knows type" do
    counter = Crdts::GCounter.new
    counter.type.should be(1)
  end

  it "should be iterable" do
    expected = [
      double('replicated integer', :name => 'client-1', :value => 3),
      double('replicated integer', :name => 'client-2', :value => 8),
    ]

    actual = {}
    collection = Crdts::GCounter.new(expected)
    collection.each do |key, value|
      actual[key] = value
    end
    actual.should eq({
      'client-1' => 3,
      'client-2' => 8,
    })
  end

  describe "#value" do
    it "returns collection sum" do
      collection = double('collection', :sum => 2)
      counter = Crdts::GCounter.new(collection)
      counter.value.should be(2)
    end
  end

  describe "#increment" do
    before do
      @collection = double('collection')
      @replica = double('replica')
      @integer = double('replica integer', :increment => nil)
      @counter = Crdts::GCounter.new(@collection)
      @collection.stub(:get) { @integer }
    end

    it "returns self" do
      @result = @counter.increment(@replica)
      @result.should equal(@counter)
    end

    it "increments value by 1" do
      @collection.should_receive(:get).with(@replica).and_return(@integer)
      @integer.should_receive(:increment).with(1)
      @counter.increment(@replica)
    end

    context "with value to increment by" do
      it "increments by value" do
        @collection.should_receive(:get).with(@replica).and_return(@integer)
        @integer.should_receive(:increment).with(3)
        @counter.increment(@replica, 3)
      end
    end
  end

  describe "#eql?" do
    it "returns true when same class and name" do
      collection = double('collection')
      counter = Crdts::GCounter.new(collection)
      counter.should eql(Crdts::GCounter.new(collection))
    end

    it "returns false when same class, but different name" do
      collection = double('collection')
      counter = Crdts::GCounter.new(collection)
      counter.should_not eql(Crdts::GCounter.new)
    end

    it "returns false when different class" do
      collection = double('collection')
      counter = Crdts::GCounter.new(collection)
      counter.should_not eql(Object.new)
    end
  end

  describe "#==" do
    it "returns true when same class and name" do
      collection = double('collection')
      counter = Crdts::GCounter.new(collection)
      counter.should eq(Crdts::GCounter.new(collection))
    end

    it "returns false when same class, but different name" do
      collection = double('collection')
      counter = Crdts::GCounter.new(collection)
      counter.should_not eq(Crdts::GCounter.new)
    end

    it "returns false when different class" do
      collection = double('collection')
      counter = Crdts::GCounter.new(collection)
      counter.should_not eq(Object.new)
    end
  end
end
