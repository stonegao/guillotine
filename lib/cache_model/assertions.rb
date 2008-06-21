module Guillotine
  module Assertions
    private
    
    def assert_each_expression(&blk)
      yield
      return true
    rescue Assertion::AssertionFailedError
      return false
    end
    
    def assert(expression)
      Assertion.assert(expression)
    end
    
    def assert_equal(expr1, expr2)
      Assertion.assert(expr1 == expr2)
    end
    
    class Assertion
      class AssertionFailedError < StandardError; end
      
      def self.assert(expression)
        new.assert(expression)
      end
      
      def assert(expression)
        expression ? true : (raise AssertionFailedError)
      end
    end
  end
end
