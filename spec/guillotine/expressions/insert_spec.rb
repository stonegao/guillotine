require File.dirname(__FILE__) + "/../../spec_helper"

module Guillotine
  module Expressions
    describe Insert do
      it "should have a table name to insert into" do
        insert = Insert.new
        insert.into = :a_table
        insert.into.should equal(:a_table)
      end
      
      it "should allow the table in the init" do
        insert = Insert.new(:into => :a_table)
        insert.into.should == :a_table
      end
      
      it "should have a list of columns" do
        insert = Insert.new
        insert.columns = [:foo, :bar]
        insert.columns.should == [:foo, :bar]
      end
      
      it "should allow the columns in the init" do
        Insert.new(:columns => [:foo, :bar]).columns.should == [:foo, :bar]
      end
      
      it "should raise an error if an unknown key is given in the init" do
        lambda { 
          Insert.new(:foo => [:bar])
        }.should raise_error(Insert::UnknownInsertExpression, "foo is not a valid insert key")
      end
      
      it "should have a list of values" do
        insert = Insert.new
        insert.values = ["foo", "bar"]
        insert.values.should == ["foo", "bar"]
      end
      
      describe "to_sql" do
        it "should return the correct string with an into and values clause" do
          insert = Insert.new(:into => :foo, :values => [1,2,3])
          insert.to_sql.should == "INSERT INTO foo VALUES (1, 2, 3)"
        end
        
        it "should use the correct table name" do
          insert = Insert.new(:into => :bar, :values => [1,2,3])
          insert.to_sql.should == "INSERT INTO bar VALUES (1, 2, 3)"
        end
        
        it "should use the correct values" do
          insert = Insert.new(:into => :bar, :values => [3,2,1])
          insert.to_sql.should == "INSERT INTO bar VALUES (3, 2, 1)"
        end
        
        it "should properly escape a string value" do
          insert = Insert.new(:into => :users, :values => ["Scott"])
          insert.to_sql.should == "INSERT INTO users VALUES (\"Scott\")"
        end
        
        it "should use a column if specified" do
          insert = Insert.new(:into => :users, :columns => [:username], :values => ["Scott"])
          insert.to_sql.should == "INSERT INTO users (username) VALUES (\"Scott\")"
        end
        
        it "should allow multiple columns" do
          insert = Insert.new(:into => :users, :columns => [:num_one, :num_two], :values => [1, 2])
          insert.to_sql.should == "INSERT INTO users (num_one, num_two) VALUES (1, 2)"
        end
      end
      
      describe "==" do
        it "should be false if the table name is not equal" do
          one = Insert.new(:into => :bar)
          two = Insert.new(:into => :foo)
          one.should_not == two
          two.should_not == one
        end
        
        it "should be true if the table name is the same and the values are the same" do
          options = {
            :into => :foo,
            :values => []
          }
          one = Insert.new(options)
          two = Insert.new(options)
          one.should == two
          two.should == one
        end
        
        it "should be false if the table name is the same but the values are different" do
          options = {
            :into => :foo,
            :values => []
          }
          one = Insert.new(:into => :foo, :values => [1])
          two = Insert.new(:into => :foo, :values => [2])
          one.should_not == two
          two.should_not == one
        end
        
        it "should not raise an error when given an object which does not respond to table_name" do
          lambda {
            Insert.new(:into => :foo, :values => []) == Object.new
          }.should_not raise_error
        end
        
        it "should be false if the object is not an Insert" do
          Insert.new(:into => :foo, :values => []).should_not == Object.new
        end
        
        it "should *actually* return false, not nil" do
          (Insert.new(:into => :foo, :values => []) == Object.new).should be_false
        end
        
        describe "when columns are specified on both" do
          it "should be true if the values and columns are in the same order" do
            one = Insert.new(:into => :foo, :columns => [:one, :two], :values => [:one, :two])
            two = Insert.new(:into => :foo, :columns => [:one, :two], :values => [:one, :two])
            one.should == two
            two.should == one
          end
          
          it "should be false if the values are in the same order, but the columns aren't" do
            one = Insert.new(:into => :foo, :columns => [:two, :one], :values => [:one, :two])
            two = Insert.new(:into => :foo, :columns => [:one, :two], :values => [:one, :two])
            one.should_not == two
            two.should_not == one
          end
          
          it "should be true if the columns and values are in the same relative order" do
            one = Insert.new(:into => :foo, :columns => [:two, :one], :values => [3, 4])
            two = Insert.new(:into => :foo, :columns => [:one, :two], :values => [4, 3])
            one.should == two
            two.should == one
          end
        end
        
        # TODO
        describe "when columns are specified on only one of the objects being compared"
      end
    end
  end
end