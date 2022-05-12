require_relative '../lib/player.rb'

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
    introduce_player(player1)
    introduce_player(player2)
    randomize_first_turn
  end

  def create_players
    @player1 = Player.new(choose_name(1), choose_symbol)
    @player2 = Player.new(choose_name(2), assign_symbol)
  end

  def choose_name(player_number)
    puts "\nPlayer #{player_number}, enter your name:"
    gets.chomp.capitalize
  end

  def introduce_player(name)
    puts "\n#{name} will be #{name.symbol}."
  end

  def choose_symbol
    puts "\n#{player1.name}, choose your symbol (X or O):"
    symbol = gets.chomp.capitalize
    return symbol if valid_symbol?(symbol)

    choose_symbol
  end

  def valid_symbol?(symbol)
    return true if symbol == 'X' || symbol == 'O'

    puts 'Invalid symbol.'
  end

  def assign_symbol
    player1.symbol == 'X' ? 'O' : 'X'
  end

  def randomize_first_turn
    @current_player = [player1, player2].sample
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

  def game_over?
    game_won? || game_tied?
  end

  def intro_message
    puts "\nLet's play Tic Tac Toe!"
    puts "\nPlayers can make a move by entering a number between 1 and 9. Let's get started."
  end

  def display_board
    puts "\n #{@positions[0]} | #{@positions[1]} | #{@positions[2]} "
    puts '-----------'
    puts " #{@positions[3]} | #{@positions[4]} | #{@positions[5]} "
    puts '-----------'
    puts " #{@positions[6]} | #{@positions[7]} | #{@positions[8]} "
  end

  private

  def game_won?
    WINNING_COMBINATIONS.any? do |combination|
      combination.all? { |position| @positions[position] == 'X' } ||
      combination.all? { |position| @positions[position] == 'O' }
    end
  end

  def game_tied?
    (@positions.all? { |position| position == 'X' || position == 'O' }) && !game_won?
  end

  def valid_move?(move)
    return true if @positions[move - 1].is_a? Integer

    puts 'Invalid move, please try again.'
  end

  def switch_turns
    current_player == player1 ? player2 : player1
  end
end

Game.new
