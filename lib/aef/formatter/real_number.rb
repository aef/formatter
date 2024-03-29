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

module Aef
  module Formatter
    class RealNumber
      attr_accessor :real_number
    
      def initialize(real_number = nil)
        @real_number = real_number
        @padding_length = 0
        @padding_character = ''.freeze
    
        if real_number.is_a?(Integer)
          @precision_digits = 0
        else
          @precision_digits = :infinite
        end
    
        @decimal_separator = '.'.freeze
        @integer_separator = ' '.freeze
        @integer_separator_step = 0
      end
    
      def padding(length, character = '0')
        @padding_length    = length.to_i
        @padding_character = character.to_s.freeze
    
        self.dup
      end
    
      def precision(digits)
        if digits == :infinite
          @precision_digits = :infinite
        else
          @precision_digits = digits.to_i
        end
    
        self.dup
      end
    
      def decimal_separator(separator)
        @decimal_separator = separator.to_s.freeze
    
        self.dup
      end
    
      def integer_separator(separator = ' ', step = 3)
        @integer_separator = separator.to_s.freeze
        @integer_separator_step = step
    
        self.dup
      end
    
      def to_s
        return "#<#{self.class.name}: No number set>" unless @real_number
    
        if @precision_digits == :infinite
          format = '%f'
        elsif @precision_digits == 0
          format = "%i"
        else
          format = "%.#{@precision_digits}f"
        end
    
        representation = format % @real_number
    
        signed_integer, fractional = *representation.split(/\./)
    
        original, sign, integer = */([+-]?)(.*)/.match(signed_integer)
    
        integer = "%#{@padding_character}#{@padding_length}i" % integer.to_i
    
        if @integer_separator_step > 0
          integer = integer.reverse.chars.each_slice(@integer_separator_step).map{|slice| slice.join}.join(@integer_separator).reverse
        end
    
        components = ["#{sign}#{integer}"]
        components << fractional if fractional
        components.join(@decimal_separator)
      end
    
      protected
    
      def method_missing(name, *args)
        to_s.method(name).call(*args)
      end
    end
  end
end
