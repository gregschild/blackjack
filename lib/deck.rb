$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'constants'
require 'card'

class Deck
  attr_reader :pack

  def initialize(number_of_decks)

    @pack = []

    number_of_decks.times do
      RANKS.each do |rank|
        SUITS.each do |suit|
          @pack.push(Card.new(rank, suit))
        end
      end
    end
  end

  def shuffle
    @pack.shuffle!
  end

  def deal
    return @pack.shift
  end

end