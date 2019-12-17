#!/usr/bin/env ruby
# encoding: utf-8

$: << File.dirname(__FILE__)

require 'helper'

class RailsJuice < Minitest::Test

  def test_bigdecimal_dump
    orig = Oj.default_options
    Oj.default_options = { mode: :rails, bigdecimal_as_decimal: true }
    bd = BigDecimal('123')
    json = Oj.dump(bd)
    Oj.default_options = orig

    assert_equal('0.123e3', json)
    
    json = Oj.dump(bd, mode: :rails, bigdecimal_as_decimal: false)
    assert_equal('"0.123e3"', json)

    json = Oj.dump(bd, mode: :rails, bigdecimal_as_decimal: true)
    assert_equal('0.123e3', json)
  end

end