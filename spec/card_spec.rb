require 'spec_helper'
require 'card'

describe Card do
  before do
    @rank = '8'
    @suit = 'Spades'
    @card = Card.new(@rank, @suit)
  end

  %w(rank suit value is_hidden to_s).each do |v|

    it "should respond to :#{v}" do
      expect(@card).to respond_to(v.to_sym)
    end

  end

  it "should only allow valid suits" do
    expect(SUITS).to be_include(@card.suit)
    expect { Card.new('K', 'Clbus') }.to raise_error(ArgumentError)
  end

  it "should only allow valid ranks" do
    expect(RANKS).to be_include(@card.rank)
    expect { Card.new('a', 'Spades') }.to raise_error(ArgumentError)
  end

  it "should have the correct blackjack value" do
    expect(@card.value).to eql(VALUES[@card.rank])
  end

  it "is_hidden should be boolean" do
    expect([true, false]).to be_include(@card.is_hidden)
  end

  it "should return user readable information with .to_s" do
    expect(@card.to_s).to eql(@rank + " of " + @suit)
  end

end
