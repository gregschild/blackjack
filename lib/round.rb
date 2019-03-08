require_relative 'helper'
require 'deck'
require 'player'

class Round

  def initialize(deck)
    @deck = deck
  end

  def deal(number_of_players)
    @players = []
    number_of_players.times do
      @players.push(Player.new)
    end
    @dealer = Player.new

    @players.each do |player|
      player.deal_card(@deck)
    end

    @dealer.deal_card(@deck)
    @dealer.hand[0].is_hidden = true

    @players.each do |player|
      player.deal_card(@deck)
    end

    @dealer.deal_card(@deck)

    @players.each_with_index do |player, i|
      puts "Player " + (i + 1).to_s + " has the " + player.hand.join(' and ')
      #puts "Total: " + get_total(player.hand).join('/')
      puts "Total: " + player.total.join('/')
      sleep(0.5)
    end
    puts "Dealer is showing the " + @dealer.hand[1].to_s
    #puts "Dealer has " + get_total(@dealer.hand).join('/')
    puts "Dealer has " + @dealer.total.join('/')
    sleep(0.5)

    return @players, @dealer
  end

  def player_options
    @players.each_with_index do |player, i|
      hit_or_stick(player, i)
    end
  end

  def hit_or_stick(player, i)
    option = ''
    until ['h', 's'].include? option
      puts "Player " + (i + 1).to_s + ":(" + player.total.join('/') + ") " + "[h]it or [s]tick"
      option = gets.chomp
    end
    if option == 'h'
      player.deal_card(@deck)
      puts "Player " + (i + 1).to_s + " is dealt the " + player.hand.last.to_s
      #total = get_total(player.hand)
      total = player.total
      sleep(0.5)
      puts "Player " + (i + 1).to_s + " has " + total.join('/')
      sleep(0.5)
      hit_or_stick(player, i) unless total[0] > 21
      puts "Player " + (i + 1).to_s + " has busted!" if total[0] > 21
      sleep(0.5) if total[0] > 21
    elsif option == 's'
      #total = get_total(player.hand)
      total = player.total
      puts "Player " + (i + 1).to_s + " stands on " + total.last.to_s
      sleep(0.5)
    else
      puts "Invalid option"
    end
  end


  def dealer_runout
    @dealer.hand[0].is_hidden = false
    puts "Dealer reveals the " + @dealer.hand[0].to_s
    sleep(0.5)

    #total = get_total(@dealer.hand)
    @dealer.get_total(@dealer.hand)
    total = @dealer.total

    puts "Dealer has " + total.join('/')
    sleep(0.5)

    until total.any? { |c| c.to_i >= 17 }
      @dealer.deal_card(@deck)
      puts "Dealer draws the " + @dealer.hand.last.to_s
      #total = get_total(@dealer.hand)
      total = @dealer.total
      sleep(0.5)
      puts "Dealer has " + total.join('/')
      sleep(0.5)
      if total == [7, 17] # soft 17
        @dealer.deal_card(@deck)
        puts "Dealer draws the " + @dealer.hand.last.to_s
        total = @dealer.total
        sleep(0.5)
        unless total >= 17
          until total.any? { |c| c.to_i >= 17 }
            @dealer.deal_card(@deck)
            puts "Dealer draws the " + @dealer.hand.last.to_s
            total = @dealer.total
            sleep(0.5)
          end
        end
      end
    end

    puts "Dealer finishes with " + total.last.to_s

    puts "Dealer busts!" if total[0] > 21
    sleep(0.5)
  end


  def determine_winner
    #dealer_total = get_total(@dealer.hand).last
    dealer_total = @dealer.total.last
    @players.each_with_index do |player, i|
      #player_total = get_total(player.hand).last
      player_total = player.total.last
      if player_total > 21
        puts "Player " + (i + 1).to_s + " loses!"
        sleep(0.5)
      elsif dealer_total > 21
        puts "Player " + (i + 1).to_s + " wins!"
        sleep(0.5)
      elsif player_total > dealer_total
        puts "Player " + (i + 1).to_s + " wins!"
        sleep(0.5)
      elsif player_total == dealer_total
        puts "Player " + (i + 1).to_s + " push!"
        sleep(0.5)
      elsif player_total < dealer_total
        puts "Player " + (i + 1).to_s + " loses!"
        sleep(0.5)
      end
    end
  end


end

