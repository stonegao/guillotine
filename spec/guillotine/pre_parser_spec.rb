require File.dirname(__FILE__) + "/../spec_helper"

module Guillotine
  describe PreParser do
    before :each do
      @pre_parser = PreParser.new
    end
    
    def parse(*args)
      @pre_parser.parse(*args)
    end
    
    it "should remove any spaces at the start of the string" do
      parse("   foo").should == "FOO"
    end
    
    it "should remove any spaces at the end of the string" do
      parse("foo     ").should == "FOO"
    end
    
    it "should remove any carriage returns" do
      parse("foo\r\rbar\r\r").should == "FOOBAR"
    end
    
    it "should replace \n's with spaces" do
      parse("foo\nbar\nbaz").should == "FOO BAR BAZ"
    end
    
    it "should not have \n's at the start of a line" do
      parse("\n\nfoo\nbar\nbaz").should == "FOO BAR BAZ"
    end
    
    it "should not have \n's at the end of a line" do
      parse("\n\nfoo\nbar\nbaz").should == "FOO BAR BAZ"
    end
    
    it "should collapse multiple \n's into one space" do
      parse("foo\n\n\nbar").should == "FOO BAR"
    end
    
    describe "parse, the class method" do
      before :each do
        @pre_parser = mock 'pre-parser', :parse => "results"
        PreParser.stub!(:new).and_return @pre_parser
      end
      
      it "should create a new pre_parser" do
        PreParser.should_receive(:new).and_return @pre_parser
        PreParser.parse('a string')
      end
      
      it "should call parse on the instance with the string given" do
        @pre_parser.should_receive(:parse).with('a string').and_return "results"
        PreParser.parse('a string')
      end
    end
    
    it "should replace two spaces with one" do
      parse("foo  bar").should == "FOO BAR"
    end
    
    it "should replace three spaces with one" do
      parse("foo   bar").should == "FOO BAR"
    end
    
    it "should not change the spaces inside a single quote" do
      parse("'foo  bar'").should == "'foo  bar'"
    end
    
    it "should upcase anything outside of a quote"do
      parse("foo bar").should == "FOO BAR"
    end
    
    it "should not upcase anything inside a quote" do
      parse("foo 'bar' baz").should == "FOO 'bar' BAZ"
    end
    
    it "should not upcase if given false as it's second parameter" do
      parse("foo", false).should == "foo"
    end
    
    describe "regression 1: A Rails generated INSERT" do
      before(:each) do
        @string = "INSERT INTO `users` (`updated_at`, `username`, `created_at`) VALUES('2008-09-29 22:31:32', 'smtlaissezfaire', '2008-09-29 22:31:32')"
      end
      
      it "should parse the string" do
        @pre_parser.parse(@string).should_not be_nil
      end
      
      it "should parse and eval the string" do
        @pre_parser.parse(@string).should == "INSERT INTO `users` (`updated_at`, `username`, `created_at`) VALUES('2008-09-29 22:31:32', 'smtlaissezfaire', '2008-09-29 22:31:32')"
      end
    end
    
    describe "regression 2: A SELECT with !=" do
      before(:each) do
        @string = "foo != 'bar'"
      end
    
      it "should parse the string" do
        parse(@string).should == "FOO != 'bar'"
      end
    end
  end
end

