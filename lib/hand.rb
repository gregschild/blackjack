$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'constants'
require 'deck'

class Hand

  attr_accessor :is_dealer
  attr_reader :full_hand

  def initialize(deck, is_dealer)
    @full_hand = []
    @is_dealer = false
    @deck = deck
    2.times {
      @full_hand.push(@deck.deal)
    }
  end

  def add_card
    @full_hand.push(@deck.deal)
  end


  def hand_value
    @hand_value = 0
    temp_value = 0
    @full_hand.each do |card|
      if card.value.kind_of?(Array)
        temp_value += card.value[1]
      else
        temp_value += card.value
      end
    end
    @full_hand.each do |card|
      if card.value.kind_of?(Array)
        if temp_value > 21
          @hand_value += card.value[0]
        else
          @hand_value += card.value[1]
        end
      else
        @hand_value += card.value
      end
    end
    return @hand_value
  end
end

deck = Deck.new(2)
deck.shuffle
hand = Hand.new(deck,false)
hand.add_card


