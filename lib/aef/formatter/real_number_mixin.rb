require 'aef/formatter/real_number'

module Aef  
  module Formatter
    module RealNumberMixin
      def self.included(klass)
        klass.extend(ClassMethods)
      end

      module ClassMethods
        def formatter
          Aef::Formatter::RealNumber.new
        end
      end
    
      def formatter
        self.class.formatter
      end
    
      def format(formatter = nil)
        if formatter
          new_formatter = formatter.dup
          new_formatter.real_number = self
          new_formatter
        else
          Aef::Formatter::RealNumber.new(self)
        end
      end
    end
  end
end
