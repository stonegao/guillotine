require File.dirname(__FILE__) + "/../../../spec_helper"

module Guillotine
  module Shell
    describe OutputFormatter::ColumnLengthCalculator do
      before(:each) do
        @calculator = OutputFormatter::ColumnLengthCalculator
      end
      
      it "should find the size of '3' with a column name one char long (the size + offset)" do
        @calculator.size_of_column(:a, [""]).should == 1
      end
      
      it "should find the size of '4' with a column name two chars long" do
        @calculator.size_of_column(:ab, [""]).should == 2
      end
      
      it "should find the size of '5' with a column name one char long, and a value of 3 chars" do
        @calculator.size_of_column(:a, ["123"]).should == 3
      end
      
      it "should pick the longest column out of a range of column values" do
        @calculator.size_of_column(:a, ["1", "12"]).should == 2
      end
    end
  end
end
