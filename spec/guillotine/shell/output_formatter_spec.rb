require File.dirname(__FILE__) + "/../../spec_helper"

module Guillotine
  module Shell
    describe OutputFormatter do
      before(:each) do
        @formatter = Shell::OutputFormatter.new
        @obj = mock 'an-object'
      end
      
      describe "puts" do
        before(:each) do
          Kernel.stub!(:puts).and_return "foo"
        end
        
        it "should format the object" do
          @formatter.should_receive(:format).with(@obj).and_return "output_string"
          @formatter.puts(@obj)
        end
        
        it "should call puts with the format results" do
          @formatter.stub!(:format).with(@obj).and_return "output_string"
          
          Kernel.should_receive(:puts).with("output_string\n\n")
          
          @formatter.puts(@obj)
        end
      end
      
      describe "class format convenience method" do
        before(:each) do
          @formatter = mock 'formatter', :to_s => "some output"
          Shell::OutputFormatter.stub!(:new).and_return @formatter
          
          @an_object = mock 'an object'
        end
        
        it "should call new" do
          Shell::OutputFormatter.should_receive(:new).with(no_args).and_return @formatter
          Shell::OutputFormatter.format(@an_object)
        end
        
        it "should call to_s with the object" do
          @formatter.should_receive(:to_s).with(@an_object).and_return "some output"
          Shell::OutputFormatter.format(@an_object)
        end
      end
      
      describe "format" do
      end
      
      describe "to_s" do
        before(:each) do
          @formatter.stub!(:format).and_return "some text"
          @an_object = mock 'an object'
          Kernel.stub!(:puts).and_return "some text\n"
        end
        
        it "should call format on the object" do
          @formatter.should_receive(:format).with(@an_object).and_return "some text"
          @formatter.to_s(@an_object)
        end
        
        it "should puts the obj" do
          Kernel.should_receive(:puts).with("some text\n\n").and_return "some text\n\n"
          @formatter.to_s(@an_object)
        end
      end
    end
  end
end
