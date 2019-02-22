require_relative 'helper'
require 'deck'

class Round

  attr_accessor :bet, :stack, :dealer_hand, :player_hand

  def initialize(deck, stack, number_of_players)
    @deck = deck
    @number_of_players = number_of_players
    @bet = 10 # default for now
    puts "==================================="
    puts "Bet: " + @bet.to_s
    puts "==================================="
  end

  def deal
    @players_hands = []
    @dealers_hand = []

    @number_of_players.times do
      @players_hands.push([@deck.deal])
    end
    dealer_card = @deck.deal
    dealer_card.is_hidden = true
    @dealers_hand.push(dealer_card)

    @players_hands.each do |player|
      player.push(@deck.deal)
    end

    @dealers_hand.push(@deck.deal)

    dealer_up_card = @dealers_hand[1]

    dealer_total = get_total(@dealers_hand)

    puts "Dealer is showing: " + dealer_total.join('/')
    puts dealer_up_card.to_s
    puts "----------"
    @players_hands.each_with_index do |hand, i|
      i = i + 1
      total = get_total(hand)
      puts "Player " + i.to_s + ": " + total.join('/')
      puts hand
      puts "----------"
    end


  end

  def hit(player)
    card = @deck.deal
    @players_hands[player].push(card)
    puts "Player " + (player + 1).to_s + " is dealt the " + card.to_s
  end

  def stick(player)
    player = player + 1
    puts "Player " + player.to_s + " sticks"
  end

  def dealer_runout
    dealer_hidden_card = @dealers_hand[0]
    dealer_hidden_card.is_hidden = false
    count = get_total(@dealers_hand)

    puts "Dealer reveals the " + dealer_hidden_card.to_s
    puts "Dealer has " + count.join('/')

    until count.any? { |c| c.to_i >=17 }
      card = @deck.deal
      @dealers_hand.push(card)
      puts "Dealer draws the " + card.to_s
      count = get_total(@dealers_hand)
      puts "Dealer has " + count.join('/')
    end

    puts "Dealer busts!" if count[0] > 21
  end

  private

  def get_total(hand)
    total = [0]
    hand.each do |card|
      unless card.is_hidden
        if card.value.kind_of?(Array) # if an ace
          count = total.count
          count.times do |i|
            total.push(total[i] + card.value[1])
          end
          count.times do |i|
            total[i] = total[i] + card.value[0]
          end
        else
          total.count.times do |i|
            total[i] = total[i] + card.value
          end
        end
      end
    end
    total.delete_if { |val| val > 21 } unless total.count == 1
    total.uniq!
    total.sort_by(&:to_i)
    return total
  end

end

deck = Deck.new(2)
deck.shuffle

round = Round.new(deck, 100, 2)
round.deal
round.hit(0)
round.stick(0)
round.stick(1)
round.dealer_runout


