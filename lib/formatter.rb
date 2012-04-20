require 'bigdecimal'
require 'aef/formatter'

[Integer, Float, BigDecimal].each do |klass|
  klass.send(:include, Aef::Formatter::RealNumberMixin)
end
