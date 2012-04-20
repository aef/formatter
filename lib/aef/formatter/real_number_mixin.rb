# encoding: UTF-8
=begin
Copyright Alexander E. Fischer <aef@raxys.net>, 2012

This file is part of Formatter.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
=end

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
