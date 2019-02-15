require 'spec_helper'
require 'player'

describe Player do

  before do
    @deck = Deck.new(6)
    @deck.shuffle
    is_dealer = false
    @player = Player.new(@deck, is_dealer)
  end

  %w(hand hand_value is_dealer add_card).each do |v|
    it "should respond to :#{v}" do
      expect(@player).to respond_to(v.to_sym)
    end
  end

  it "should add a card to @hand" do
    num = 0
    5.times do
      num += 1
      hand = @player.add_card
      expect(hand.count).to eql(num)
    end
  end

  it "should raise ArgumentError if is_dealer is not boolean" do
    expect { Player.new(@deck, 'some_string') }.to raise_error(ArgumentError)
    expect([true, false]).to be_include(@player.is_dealer)
  end

end