require './lib/tic_tac_toe.rb'

describe Game do
  subject(:game) { described_class.new }

  describe '#game_won?' do
    context 'when all elements in top row are X' do      
      it 'returns true when game_won? for top row' do
        game.instance_variable_set(:@positions, ['X', 'X', 'X', 4, 5, 6, 7, 8, 9])
        expect(game).to be_game_won
      end
    end
  end
end