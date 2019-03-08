require 'spec_helper'
require 'round'
require 'deck'

describe Round do

  before do
    deck = Deck.new(6)
    @round = Round.new(deck)
  end

  %w(deal player_options hit_or_stick dealer_runout determine_winner).each do |v|
    it "should respond to :#{v}" do
      expect(@round).to respond_to(v.to_sym)
    end
  end

  it "should set first dealer card to be hidden" do
    deal = @round.deal(2)
    dealer = deal[1]

    expect(dealer.hand[0].is_hidden).to eql(true)
  end

  it "should deal one at a time to each player" do
    # Let's deal an un-shuffled deck to 4 players and a dealer
    deal = @round.deal(4)
    # deal returns an array,
    # the first element is an array of player objects
    # the second element is a player object representing the dealer
    # let's set players and dealer to the respective elements of deal array.
    players = deal[0]
    dealer = deal[1]
    # Round.deal sets the first dealer card is_hidden to true preventing us from
    # accessing the details of the card. Overriding this value let's us test
    # that card.
    dealer.hand[0].is_hidden = false

    # As the deck is un-shuffled, we know what cards each player should be dealt.
    # Let's check them all
    expect(players[0].hand[0].rank).to eql('2')
    expect(players[0].hand[0].suit).to eql('Clubs')
    expect(players[1].hand[0].rank).to eql('2')
    expect(players[1].hand[0].suit).to eql('Hearts')
    expect(players[2].hand[0].rank).to eql('2')
    expect(players[2].hand[0].suit).to eql('Spades')
    expect(players[3].hand[0].rank).to eql('2')
    expect(players[3].hand[0].suit).to eql('Diamonds')
    expect(dealer.hand[0].rank).to eql('3')
    expect(dealer.hand[0].suit).to eql('Clubs')
    expect(players[0].hand[1].rank).to eql('3')
    expect(players[0].hand[1].suit).to eql('Hearts')
    expect(players[1].hand[1].rank).to eql('3')
    expect(players[1].hand[1].suit).to eql('Spades')
    expect(players[2].hand[1].rank).to eql('3')
    expect(players[2].hand[1].suit).to eql('Diamonds')
    expect(players[3].hand[1].rank).to eql('4')
    expect(players[3].hand[1].suit).to eql('Clubs')
    expect(dealer.hand[1].rank).to eql('4')
    expect(dealer.hand[1].suit).to eql('Hearts')
  end




end