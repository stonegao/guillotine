module Guillotine
  module TestSupport
    class MysqlOverrider
      def initialize(db_connection, guillotine_connection)
        @db_connection = db_connection
        @guillotine_connection = guillotine_connection
        redefine_select!
      end
      
      attr_reader :db_connection
      attr_reader :guillotine_connection
      
      def select_from_db(sql)
        db_connection.instance_eval do
          select_aliased_from_guillotine(sql)
        end
      end
      
      def select_from_guillotine(sql)
        guillotine_connection.select(sql)
      rescue Exception
        select_from_db(sql)
      end
      
    private
      
      def redefine_select!
        mysql_adapter_self = self
        
        metaclass = class << @db_connection; self; end
        
        metaclass.instance_eval do
          alias_method :select_aliased_from_guillotine, :select
          define_method :select do |sql|
            mysql_adapter_self.select_from_guillotine(sql)
          end
        end
      end
    end
  end
end