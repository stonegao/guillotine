require File.dirname(__FILE__) + "/../../spec_helper"

module CachedModel
  
  module ParserSpecHelper
    def parse(string)
      @parser.parse(string)
    end
    
    def parse_and_eval(string, *eval_args)
      parse(string).eval(*eval_args)
    end
  end
  
  describe SQLPrimitivesParser do
    include ParserSpecHelper
    
    before :each do
      @parser = SQLPrimitivesParser.new
    end
    
    describe "number" do
      it "should parse the number 0" do
        parse_and_eval('0').should == 0
      end
      
      it "should parse the number 1" do
        parse_and_eval('1').should == 1
      end
      
      it "should parse multiple numbers" do
        parse_and_eval('123').should == 123
      end
      
      it "should not parse the empty string as a number" do
        lambda { 
          parse_and_eval('')
        }.should raise_error
      end
    end
    
    describe 'string' do
      it "should parse a single char" do
        parse_and_eval('a').should == "a"
      end
      
      it "should parse multitple chars" do
        parse_and_eval("aaaa").should == "aaaa"
      end
      
      it "should parse different chars" do
        parse_and_eval("abcd").should == "abcd"
      end
      
      it "should parse an uppercase char" do
        parse_and_eval("A").should == "A"
      end
      
      it "should parse a combination of uppercase and lowercase chars" do
        parse_and_eval("ABcdEF").should == "ABcdEF"
      end
      
      it "should parse underscores" do
        parse_and_eval("_").should == "_"
      end
    end
    
    describe "backtick string" do
      before(:each) do
        @backtick_string = mock("BacktickString")
        @backtick_class = mock('BacktickStringClass', :new => @backtick_string)
      end
      
      it "should parse a simple string properly" do
        @backtick_class.should_receive(:new).with("`foo`").and_return @backtick_string
        parse_and_eval("`foo`", @backtick_class)
      end
      
      it "should parse a different string properly" do
        @backtick_class.should_receive(:new).with("`foobar`").and_return @backtick_string
        parse_and_eval("`foobar`", @backtick_class).should == @backtick_string
      end
    end
    
    describe "quoted string" do
      it "should use single quotes" do
        parse_and_eval("'foo'").should == "foo"
      end
      
      it "should use double quotes" do
        parse_and_eval("\"foo\"").should == "foo"
      end
      
      it "should not parse if it starts with a single quote, but ends in a double quote" do
        parse("\"foo'").should be_nil
      end
      
      it "should not parse if it starts with a double quote and ends in a single quote" do
        parse("'foo\"").should be_nil
      end
      
      it "should not parse a string which has three double quotes" do
        parse('"foo"bar"').should be_nil
      end
      
      it "should match the empty string with single quotes" do
        parse_and_eval("''").should == ""
      end
      
      it "should match the empty string with double quotes" do
        parse_and_eval('""').should == ""
      end
      
      it "should properly nest single quotes" do
        parse_and_eval("\"foo'bar\"").should == "foo'bar"
      end
      
      it "should properly nest a single double quotes" do
        parse_and_eval("'foo\"bar'").should == "foo\"bar"
      end
      
      it "should properly nest two single double quotes" do
        parse_and_eval("'foo\"bar\"'").should == "foo\"bar\""
      end
    end
    
    describe "booleans" do
      it "should parse 'TRUE' as true" do
        parse_and_eval("TRUE").should be_true
      end
      
      it "should parse 'FALSE' as false" do
        parse_and_eval("FALSE").should be_false
      end
      
      it "should parse '1' as true" do
        pending 'todo'
        parse_and_eval("1").should be_true
      end
      
      it "should parse 'true' as true"
      
      it "should parse 'False' as false"
    end
  end
  
  describe SQLKeyValuePairParser do
    include ParserSpecHelper
    
    before :each do
      @parser = SQLKeyValuePairParser.new
    end
    
    describe "condition" do
      describe "with '='" do
        it "should parse foo='bar'" do
          parse_and_eval("foo='bar'").should eql(Expression::Equal.new(:foo, "bar"))
        end
        
        it "should parse baz='bar'" do
          parse_and_eval("baz='bar'").should eql(Expression::Equal.new(:baz, "bar"))
        end
        
        it "should parse foo='baz'" do
          parse_and_eval("foo='baz'").should eql(Expression::Equal.new(:foo, "baz"))
        end
        
        it "should parse foo=7" do
          parse_and_eval("foo=7").should eql(Expression::Equal.new(:foo, 7))
        end
        
        it "should parse foo = 7" do
          parse_and_eval("foo = 7").should eql(Expression::Equal.new(:foo, 7))
        end
        
        it "should parse foo != 8"  do
          parse_and_eval("foo != 8").should eql(Expression::NotEqual.new(:foo, 8))
        end
        
        it "should parse foo != \"barbaz\"" do
          parse_and_eval("foo != \"barbaz\"").should eql(Expression::NotEqual.new(:foo, "barbaz"))
        end
        
        it "should parse foo > 'bar'" do
          parse_and_eval("foo > 'bar'").should eql(Expression::GreaterThan.new(:foo, "bar"))
        end
        
        it "should parse foo < 'bar'" do
          parse_and_eval("foo < 'bar'").should eql(Expression::LessThan.new(:foo, "bar"))
        end
        
        it "should parse foo >= 7" do
          parse_and_eval("foo >= 7").should eql(Expression::GreaterThanOrEqualTo.new(:foo, 7))
        end
        
        it "should parse foo <= 7" do
          parse_and_eval("foo <= 7").should eql(Expression::LessThanOrEqualTo.new(:foo, 7))
        end
        
        it "should not parse 'ISNOT NULL" do
          parse("ISNOT NULL").should be_nil
        end
        
        it "should parse foo IS NOT NULL" do
          parse_and_eval("foo IS NOT NULL").should eql(Expression::IsNotNull.new(:foo))
        end
        
        it "should parse foo 'IS  NOT NULL'" do
          parse_and_eval("foo IS  NOT NULL").should eql(Expression::IsNotNull.new(:foo))
        end
        
        it "should parse foo 'IS NOT  NULL'" do
          parse_and_eval("foo IS NOT  NULL").should eql(Expression::IsNotNull.new(:foo))
        end
        
        it "should parse foo IS NULL" do
          parse_and_eval("foo IS NULL").should eql(Expression::IsNull.new(:foo))
        end
        
        it "should parse foo  IS NULL" do
          parse_and_eval("foo  IS NULL").should eql(Expression::IsNull.new(:foo))
        end
        
        it "should parse foo IS  NULL" do
          parse_and_eval("foo IS  NULL").should eql(Expression::IsNull.new(:foo))
        end
        
        it "should not parse fooIS NULL" do
          parse("fooIS NULL").should be_nil
        end
        
        it "should not parse foo ISNULL" do
          parse("foo ISNULL").should be_nil
        end
      end
    end
  end
    
  describe SQLSelectParser do
    include ParserSpecHelper
    
    before :each do
      @parser = SQLSelectParser.new
      @equal_expression = Expression::Equal.new(:foo, 7)
      @bar_equals_eight_expr = Expression::Equal.new(:bar, 8)
    end
    
    it "should parse a simple where clause with one expression" do
      parse_and_eval("WHERE foo = 7").should eql(@equal_expression)
    end
    
    it "should parse a simple clause with two AND expressions" do
      @and_expression = ConjunctionConditionNode.new(@equal_expression, @equal_expression)
      parse_and_eval("WHERE foo = 7 AND foo = 7").should eql(@and_expression)
    end
    
    it "should parse a simple clause with two AND expressions" do
      @and_expression = ConjunctionConditionNode.new(@equal_expression, @bar_equals_eight_expr)
      parse_and_eval("WHERE foo = 7 AND bar = 8").should eql(@and_expression)
    end
    
    it "should parse a clause with three AND expressions" do
      pending 'todo'
      @first_and_expr = ConjunctionConditionNode.new(@equal_expression, @equal_expression)
      @second_and_expr = ConjunctionConditionNode.new(@first_and_expr, @bar_equals_eight_expr)
      parse_and_eval("WHERE foo = 7 AND foo = 7 AND bar = 8").should eql(@second_and_expr)
    end
  end
end
