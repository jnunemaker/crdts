module Crdts
  module Converters
    class Hash
      def dump(counter)
        element = {}
        counter.each { |name, value| element[name] = value }
        hash = {:type => counter.type, :element => element}
      end

      def load(hash)
        assert_required_keys(hash, :type, :element)

        items = []
        hash[:element].each do |name, value|
          replica = Crdts::Replica.new(name)
          integer = Crdts::Integer.new(value)
          items << Crdts::ReplicatedInteger.new(replica, integer)
        end

        collection = Crdts::ReplicatedIntegerCollection.new(items)
        Crdts::GCounter.new(collection)
      end

      private

      def assert_required_keys(hash, *required_keys)
        required_keys = required_keys.flatten
        keys = hash.keys
        required_keys.flatten.each do |key|
          raise ArgumentError, "#{key.inspect} is a required key" unless keys.include?(key)
        end
      end
    end
  end
end
