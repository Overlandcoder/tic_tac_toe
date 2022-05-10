class Game
  attr_reader :current_player, :player1, :player2

  WINNING_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze

  def initialize
    @positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def setup
    display_board
    intro_message
    create_players
    randomize_first_turn
  end

  def intro_message
    puts "\nLet's play Tic Tac Toe!"
    puts "\nPlayers can make a move by entering a number between 1 and 9. Let's get started."
  end

  def create_players
    @player1 = Player.new(choose_name(1), choose_symbol)
    puts "\n#{player1.name} will be #{player1.symbol}."
    @player2 = Player.new(choose_name(2), assign_symbol)
    puts "\n#{player2.name} will be #{player2.symbol}."
  end

  def choose_name(player_number)
    puts "\nPlayer #{player_number}, enter your name:"
    @name = gets.chomp.capitalize
  end

  def choose_symbol
    puts "\n#{@name}, choose your symbol (X or O):"
    symbol = gets.chomp.capitalize
    return symbol unless invalid_symbol?(symbol)

    choose_symbol
  end

  def invalid_symbol?(symbol)
    return unless symbol != 'X' && symbol != 'O'

    puts 'Invalid symbol.'
  end

  def assign_symbol
    player1.symbol == 'X' ? 'O' : 'X'
  end

  def randomize_first_turn
    @current_player = [player1, player2].sample
  end

  def switch_turns
    current_player == player1 ? player2 : player1
  end

  def play_game
    setup

    until game_over?
      @current_player = switch_turns
      display_board
      mark(solicit_move)
    end
    display_board
    puts "\n#{current_player.name} wins!" if game_won?
    puts "\nTie game." if game_tied?
  end

  def solicit_move
    puts "\n#{current_player.name}, make your move."
    move = gets.chomp.to_i
    return move if valid_move?(move)

    solicit_move
  end

  def mark(position)
    @positions[position - 1] = current_player.symbol
  end

  def game_won?
    triple_x? || triple_o?
  end

  def triple_x?
    WINNING_COMBINATIONS.any? do |combination|
      combination.all? { |position| @positions[position] == 'X' }
    end
  end

  def triple_o?
    WINNING_COMBINATIONS.any? do |combination|
      combination.all? { |position| @positions[position] == 'O' }
    end
  end

  def game_tied?
    (@positions.all? { |position| position == 'X' || position == 'O' }) && !game_won?
  end

  def game_over?
    game_won?|| game_tied?
  end

  def valid_move?(move)
    return true if @positions[move - 1].is_a? Integer

    puts 'Invalid move, please try again.'
  end

  def display_board
    puts "\n #{@positions[0]} | #{@positions[1]} | #{@positions[2]} "
    puts '-----------'
    puts " #{@positions[3]} | #{@positions[4]} | #{@positions[5]} "
    puts '-----------'
    puts " #{@positions[6]} | #{@positions[7]} | #{@positions[8]} "
  end
end

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

Game.new
