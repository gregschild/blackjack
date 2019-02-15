require 'spec_helper'
require 'round'
require 'hand'
require 'deck'
require 'card'

describe Round do

  before do
    #$stdin = StringIO.new('10')
    deck = Deck.new(6)
    deck.shuffle
    stack = 100


    @round = Round.new(deck, stack)
    allow(@round).to receive()
  end

  %w(bet stack get_bet).each do |v|
    it "should respond to :#{v}" do
      expect(@round).to respond_to(v.to_sym)
    end
  end

  it "bet should be integer" do
    #allow(@round).to receive(:gets).and_return('10')
    puts @round.bet
    #allow_instance_of(@round).to receive(:gets).and_return('10')
    expect(@round.bet).to be_kind_of(Integer)
  end


end