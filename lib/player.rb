$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'constants'
require 'deck'
require 'card'

class Player

  attr_reader :hand, :total

  def initialize
    @hand = []
    @total = []
  end

  def deal_card(deck)
    @hand.push(deck.deal)
    get_total(@hand)
  end

  def get_total(hand)
    total = [0, 0]
    hand.each do |card|
      unless card.is_hidden
        if card.rank.eql?('A')
          total[1] = total[0] + card.value[1]
          total[0] = total[0] + card.value[0]
        else
          total[0] = total[0].to_i + card.value
          total[1] = total[1].to_i + card.value
        end
      end
    end
    total.uniq!
    total.sort_by(&:to_i)
    total.keep_if do |t|
      t == total[0] || t <= 21
    end
    @total = total
  end



end


