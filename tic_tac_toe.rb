class Game
  def initialize
    create_players
  end

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
