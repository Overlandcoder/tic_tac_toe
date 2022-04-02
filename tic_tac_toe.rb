class Game
  def initialize
    create_players
  end

  def create_players
    get_name(1)
    get_symbol
    player1 = Player.new(@name, @symbol)
    get_name(2)
    player2 = Player.new(@name, @symbol)
  end

  def get_name(player_number)
    puts "Player #{player_number}, enter your name:"
    @name = gets.chomp
  end

  def get_symbol
    puts "#{@name.capitalize}, choose your symbol (X or O):"
    @symbol = gets.chomp
  end
end

class Player
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    puts "New player created"
  end
end

game = Game.new
