class Game
attr_reader :current_player, :player1, :player2, :symbol

  WINNING_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

  def initialize
    @positions = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    create_players
    first_turn
    play_game
  end

  def create_players
    choose_name(1)
    choose_symbol
    @player1 = Player.new(@name, @symbol)
    choose_name(2)
    assign_symbol
    @player2 = Player.new(@name, @symbol)
  end

  def choose_name(player_number)
    puts "Player #{player_number}, enter your name:"
    @name = gets.chomp
  end

  def choose_symbol
    puts "#{@name.capitalize}, choose your symbol (X or O):"
    @symbol = gets.chomp.capitalize
    if symbol != "X" && symbol != "O"
      puts "Invalid symbol."
      choose_symbol
    end
  end

  def assign_symbol
    if player1.symbol == "X"
      @symbol = "O"
    else
      @symbol = "X"
    end
  end

  def first_turn
    @current_player = [player1, player2].sample
  end

  def switch_turns
    current_player == player1 ? @current_player = player2 : @current_player = player1
  end

  def play_game
    until game_won?
      display_board
      solicit_move
      mark(@move)
      switch_turns unless game_over?
    end
  end

  def solicit_move
    puts "\n#{current_player.name.capitalize}, it's your turn to make a move."
    @move = gets.chomp.to_i
  end

  def mark(position)
    @positions[position] = current_player.symbol
  end

  def game_won?
    WINNING_COMBINATIONS.each do |combo|
      if (@positions[combo[0]] == "X" && @positions[combo[1]] == "X" && @positions[combo[2]] == "X")
        puts "#{current_player.name.capitalize} wins."
        return true
      elsif (@positions[combo[0]] == "O" && @positions[combo[1]] == "O" && @positions[combo[2]] == "O")
        puts "#{current_player.name.capitalize} wins."
        return true
      end
    end
    return false
  end

  def game_tied?
  end

  def game_over?
    game_tied? || game_won?
  end

  def winner
    if player1.symbol == "X"
      player1.name
    elsif player2.symbol == "X"
      player2.name
    end
  end

  def display_board
    puts " #{@positions[0]} | #{@positions[1]} | #{@positions[2]} "
    puts "-----------"
    puts " #{@positions[3]} | #{@positions[4]} | #{@positions[5]} "
    puts "-----------"
    puts " #{@positions[6]} | #{@positions[7]} | #{@positions[8]} "
  end
end

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    puts "#{name.capitalize} will be #{symbol}."
  end
end

game = Game.new
