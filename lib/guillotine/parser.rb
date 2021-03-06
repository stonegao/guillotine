
require "date"
require "time"
require "treetop"

module Guillotine
  module Parser
    class SQLParseError < StandardError; end

    Expressions      = Guillotine::Expressions       unless defined?(Expressions)
    
    SelectExpression = Expressions::SelectExpression unless defined?(SelectExpression)
    DeleteStatement  = Expressions::DeleteStatement  unless defined?(DeleteStatement)
    Truncate         = Expressions::Truncate         unless defined?(Truncate)
    
    Select           = Expressions::Select           unless defined?(Select)
    From             = Expressions::From             unless defined?(From)
    Limit            = Expressions::Limit            unless defined?(Limit)
    OrderBy          = Expressions::OrderBy          unless defined?(OrderBy)
    OrderByPair      = Expressions::OrderByPair      unless defined?(OrderByPair)
    GroupBy          = Expressions::GroupBy          unless defined?(GroupBy)
    BacktickString   = Expressions::BacktickString   unless defined?(BacktickString)

    Insert           = Expressions::Insert           unless defined?(Insert)
  end
  
  require File.dirname(__FILE__) + "/../../ext/quotes_parser/quotes_parser.so"
  
  parser = File.dirname(__FILE__) + "/parser"
  require "#{parser}/sql_tokens"
  require "#{parser}/sql_primitives"
  require "#{parser}/sql_helpers"
  require "#{parser}/sql_chars"
  require "#{parser}/sql_row_support"
  require "#{parser}/sql_key_value_pair"
  require "#{parser}/sql_where_condition"
  require "#{parser}/sql_limit"
  require "#{parser}/sql_order_by_clause"
  require "#{parser}/sql_group_by_clause"  
  require "#{parser}/sql_from_clause"
  require "#{parser}/sql_select_clause"
  require "#{parser}/sql_select"
  require "#{parser}/sql_truncate"
  require "#{parser}/sql_delete"
  require "#{parser}/sql_drop_table"
  require "#{parser}/sql_show_tables"
  require "#{parser}/sql_transaction"
  require "#{parser}/sql_insert"
  require "#{parser}/sql_datatypes"
  require "#{parser}/sql_create_table"
  require "#{parser}/sql"
end
