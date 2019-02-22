require 'spec_helper'
require 'round'
require 'deck'

describe Round do

  before do
    deck = Deck.new(6)
    deck.shuffle
    stack = 100
    @round = Round.new(deck, stack)
  end

  %w(bet stack).each do |v|
    it "should respond to :#{v}" do
      expect(@round).to respond_to(v.to_sym)
    end
  end

  it "bet should be integer" do
    expect(@round.bet).to be_kind_of(Integer)
  end






end