require_relative 'helper'
require 'card'
require 'deck'
require 'player'
require 'round'

class Blackjack

  deck = Deck.new(6)
  deck.shuffle
  round = Round.new(deck)
  round.deal(10)
  round.player_options
  round.dealer_runout
  round.determine_winner

end


Blackjack