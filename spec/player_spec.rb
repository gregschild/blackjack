require 'spec_helper'
require 'player'

describe Player do

  before do
    @deck = Deck.new(6)
    @deck.shuffle
    @player = Player.new
  end

  %w(hand deal_card get_total total).each do |v|
    it "should respond to :#{v}" do
      expect(@player).to respond_to(v.to_sym)
    end
  end

  it "should add a card to @hand" do
    num = 0
    5.times do
      num += 1
      hand = @player.deal_card(@deck)
      expect(hand.count).to eql(num)
    end
  end



end