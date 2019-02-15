$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'constants'

class Card
  attr_accessor :rank, :suit, :is_hidden
  attr_reader :value

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @is_hidden = false

    if !SUITS.include?(@suit)
      raise ArgumentError.new("\"suit\" not a valid value. Must be one of " + SUITS.join(','))
    end
    if !RANKS.include?(@rank)
      raise ArgumentError.new("\"rank\" not a valid value. Must be one of " + RANKS.join(','))
    end

    @value = VALUES[@rank]

  end

  def to_s
    return @rank + " of " + @suit unless is_hidden
  end

end
