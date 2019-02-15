$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'constants'
require 'deck'

class Player
  attr_accessor :is_dealer
  attr_reader :hand, :hand_value

  def initialize(deck, is_dealer)
    @is_dealer = is_dealer
    unless [true, false].include?(is_dealer)
      raise ArgumentError.new("is_dealer must be boolean.")
    end
    @hand = []
    @deck = deck
  end

  def add_card
    @hand.push(@deck.deal)
  end

end


