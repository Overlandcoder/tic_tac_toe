class Game
  def initialize
    @positions = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    create_players
    display_board
  end

  WINNING_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

  def create_players
    get_name(1)
    get_symbol
    @player1 = Player.new(@name, @symbol)
    get_name(2)
    assign_symbol
    @player2 = Player.new(@name, @symbol)
  end

  def get_name(player_number)
    puts "Player #{player_number}, enter your name:"
    @name = gets.chomp
  end

  def get_symbol
    puts "#{@name.capitalize}, choose your symbol (X or O):"
    @symbol = gets.chomp.capitalize
  end

  def assign_symbol
    if @player1.symbol == "X"
      @symbol = "O"
    else
      @symbol = "X"
    end
  end

  def randomize_turn
    rand(2)
  end

  def display_board
    puts " #{@positions[0]} | #{@positions[1]} | #{@positions[2]} "
    puts "-----------"
    puts " #{@positions[3]} | #{@positions[4]} | #{@positions[5]} "
    puts "-----------"
    puts " #{@positions[6]} | #{@positions[7]} | #{@positions[8]} "
  end

  def game_won?
    WINNING_COMBINATIONS.each do |combo|
      if (@positions[combo[0]] == "X" && @positions[combo[1]] == "X" && @positions[combo[2]] == "X")
        puts "#{winner} wins."
        return true
      elsif (@positions[combo[0]] == "O" && @positions[combo[1]] == "O" && @positions[combo[2]] == "O")
        puts "#{winner} wins."
        return true
      end
    end
  end

  def winner
    if @player1.symbol == "X"
      @player1.name
    elsif @player2.symbol == "X"
      @player2.name
    end
  end
end

class Player
  attr_reader :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    puts "#{name.capitalize} will be #{symbol}."
  end
end

game = Game.new
