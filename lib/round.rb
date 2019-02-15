$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'constants'
require 'hand'
require 'deck'

class Round
  attr_accessor :bet, :stack

  def initialize(deck, stack)
    @stack = stack
    @deck = deck
  end

  def get_bet
    print "Enter bet amount: "
    @bet = gets.chomp.to_i
  end
end

deck = Deck.new(2)
deck.shuffle
round = Round.new(deck, 100)
round.get_bet
puts round.bet

