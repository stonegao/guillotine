module Guillotine
  module Parser
    class QuotesParser
      SINGLE_QUOTE = "'"
      DOUBLE_QUOTE = '"'
      BACKTICK     = '`'
      SPACE = " "
      
      def initialize
        @at = 0
        @buffer = ""
        @in_quotes = false
      end
      
      def parse(string)
        @original_content = string.strip
        @length = @original_content.length
        
        while chars_left?
          process_char 
        end
        
        self
      end
      
      def eval
        @buffer
      end
      
    private
      
      def process_char
        eat_whitespace
        add_current_char if chars_left?
      end
      
      def add_current_char
        update_quote_status
        @buffer << current_char
        advance_char
      end
      
      def update_quote_status
        if @in_quotes && current_char == @start_quote
          @in_quotes = false
          @start_quote = nil
        elsif !@in_quotes && (current_char == SINGLE_QUOTE || current_char == DOUBLE_QUOTE || current_char == BACKTICK)
          @in_quotes = true
          @start_quote = current_char
        end
      end
      
      def advance_char
        @at += 1
      end
      
      def eat_whitespace
        if @in_quotes == false && current_char == SPACE && next_char == SPACE
          advance_char 
          eat_whitespace
        end
      end
      
      def current_char
        @original_content[@at].chr
      end
      
      def next_char
        if next_char = @original_content[@at+1]
          next_char.chr
        end
      end
      
      def chars_left?
        @length > @at
      end
    end
  end
end