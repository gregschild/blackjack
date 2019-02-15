require 'spec_helper'
require 'hand'
require 'deck'
require 'card'

describe Hand do

  before do
    deck = Deck.new(6)
    @hand = Hand.new(deck,false)
  end

  %w(full_hand hand_value add_card is_dealer).each do |v|
    it "should respond to :#{v}" do
      expect(@hand).to respond_to(v.to_sym)
    end
  end

  it "should initially deal two cards" do
    expect(@hand.full_hand.count).to eql(2)
  end

  it "should have the correct number of cards after calling .add_card" do
    num = 2
    5.times do
      num += 1
      @hand.add_card
      expect(@hand.full_hand.count).to eql(num)
    end
  end

  it "should return initial hand value" do
    expect(@hand.hand_value).to_not be_nil
  end

  it "should return a different hand value after .add_card" do
    num = 2
    old_val = 0
    5.times do
      num += 1
      @hand.add_card
      expect(@hand.hand_value).to_not be_nil
      expect(@hand.hand_value).to_not eql(old_val)
      old_val = @hand.hand_value
    end
  end

  it "is_dealer should be boolean" do
    expect([true, false]).to be_include(@hand.is_dealer)
  end


end
