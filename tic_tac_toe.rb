class Game
  def initialize
    #create_players
    display_board
  end

  POSITIONS = ["_", "_", "_", "_", "_", "_", " ", " ", " "]

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
    @symbol = gets.chomp
  end

  def assign_symbol
    if @player1.symbol.downcase == "x"
      @symbol = "o"
    else
      @symbol = "x"
    end
  end

  def randomize_turn
    rand(2)
  end

  def display_board
    puts "#{POSITIONS[0]}|#{POSITIONS[1]}|#{POSITIONS[2]}"
    puts "#{POSITIONS[3]}|#{POSITIONS[4]}|#{POSITIONS[5]}"
    puts "#{POSITIONS[6]}|#{POSITIONS[7]}|#{POSITIONS[8]}"
  end
end

class Player
  attr_reader :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    puts "New player created, #{name}, #{symbol}"
  end
end

game = Game.new
