require "rubygems"
require "active_record"

module Guillotine
  module TestSupport
    class RSpec
      class << self
        def before_all
          instance.start
        end
        
        def before_each
          instance.reload
        end
        
        def instance
          @instance ||= new
        end
        
        def reset_instance!
          @instance = nil
        end
      end
      
      def connection
        @connection ||= Connection.new
      end
      
      def active_record_base
        @active_record_base ||= ActiveRecord::Base
      end
      
      def active_record_connection
        active_record_base.connection
      end
      
      def mysql_overrider
        @mysql_overrider ||= MysqlOverrider.new(active_record_connection, connection)
      end
      
      attr_writer :active_record_base
      
      def start
        mysql_overrider
        true
      end
      
      def reload
        connection.rollback!
        true
      end
    end
  end
end
