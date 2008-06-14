module CachedModel
  module Expression
    class Base
      def initialize(key, value)
        @key = key
        @value = value
      end
      
      attr_reader :key
      attr_reader :value
      
      def to_lambda
        raise NotImplementedError
      end
      
      def eql?(other)
        self.class == other.class &&
        other.key == self.key &&
        other.value == self.value
      end
      
      alias_method :==, :eql?
      
    private
      
      def new_lambda_with_comparison(comparison)
        lambda { |obj| obj.send(self.key).send(comparison, self.value) }
      end
    end
  end
end