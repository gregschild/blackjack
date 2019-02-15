require 'spec_helper'
require 'deck'

describe Deck do

  before do
    @number_of_decks = 6
    @deck = Deck.new(@number_of_decks)
  end

  %w(pack shuffle deal).each do |v|

    it "should respond to :#{v}" do
      expect(@deck).to respond_to(v.to_sym)
    end

  end

  it "should generate the correct number of cards" do
    expect(@deck.pack.count).to eql(52*@number_of_decks)
  end

  it "deal method should return a single card" do
    expect(@deck.deal.to_s.split('\n').count).to eql(1)
  end

end