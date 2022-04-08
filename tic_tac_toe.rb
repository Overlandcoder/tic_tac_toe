class Game
attr_reader :current_player, :player1, :player2, :symbol

WINNING_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

  def initialize
    @positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    display_board
    introduction
    create_players
    randomize_first_turn
    play_game
  end

  def introduction
    puts "\nLet's play Tic Tac Toe!"
    puts "\nPlayers can make a move by entering a number between 1 and 9. Let's get started."
  end

  def create_players
    @player1 = Player.new(choose_name(1))
    choose_symbol
    @player2 = Player.new(choose_name(2))
    assign_symbol
  end

  def choose_name(player_number)
    puts "\nPlayer #{player_number}, enter your name:"
    @name = gets.chomp.capitalize
  end

  def choose_symbol
    puts "\n#{@name}, choose your symbol (X or O):"
    @symbol = gets.chomp.capitalize
    player1.symbol = @symbol
    puts "\n#{player1.name} will be #{@symbol}."
    invalid_symbol?
  end

  def invalid_symbol?
    if symbol != "X" && symbol != "O"
      puts "Invalid symbol."
      choose_symbol
    end
  end

  def assign_symbol
    player1.symbol == "X" ? player2.symbol = "O" : player2.symbol = "X"
    puts "\n#{player2.name} will be #{player2.symbol}."
  end

  def randomize_first_turn
    @current_player = [player1, player2].sample
  end

  def switch_turns
    current_player == player1 ? @current_player = player2 : @current_player = player1
  end

  def play_game
    until game_over?
      switch_turns
      display_board
      solicit_move
      mark(@move)
    end
    display_board
  end

  def solicit_move
    puts "\n#{current_player.name}, make your move."
    @move = gets.chomp.to_i
  end

  def mark(position)
    if valid_move?
      @positions[position-1] = current_player.symbol
    else
      puts "Invalid move, please try again."
      solicit_move
      mark(@move)
    end
  end

  def game_won?
    WINNING_COMBINATIONS.each do |combo|
      if combo.all? { |position| @positions[position] == "X" }
        puts "\n#{current_player.name} wins!"
        return true
      elsif combo.all? { |position| @positions[position] == "O" }
        puts "\n#{current_player.name} wins!"
        return true
      end
    end
    return false
  end

  def game_tied?
    if (@positions.all? { |position| position == "X" || position == "O" }) && !game_won?
      puts "\nTie game."
      return true
    end
    return false
  end

  def game_over?
    game_tied? || game_won?
  end

  def valid_move?
    return true if @positions[@move-1].is_a? Integer
  end

  def display_board
    puts "\n #{@positions[0]} | #{@positions[1]} | #{@positions[2]} "
    puts "-----------"
    puts " #{@positions[3]} | #{@positions[4]} | #{@positions[5]} "
    puts "-----------"
    puts " #{@positions[6]} | #{@positions[7]} | #{@positions[8]} "
  end
end

class Player
  attr_reader :name
  attr_accessor :symbol

  def initialize(name)
    @name = name
  end
end

game = Game.new
