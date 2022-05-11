require './lib/tic_tac_toe.rb'

describe Game do
  subject(:game) { described_class.new }

  describe '#game_won?' do
    context 'when all elements in top row are X' do      
      it 'is game_won' do
        game.instance_variable_set(:@positions, ['X', 'X', 'X', 'O', 'X', 6, 7, 'O', 'O'])
        expect(game).to be_game_won
      end
    end

    context 'when all elements in middle column are X' do
      it 'is game_won' do
        game.instance_variable_set(:@positions, ['O', 'X', 3, 4, 'X', 6, 'O', 'X', 'O'])
        expect(game).to be_game_won
      end
    end

    context 'when all elements in a diagonal are O' do
      it 'is game_won' do
        game.instance_variable_set(:@positions, ['O', 'X', 3, 4, 'O', 'X', 'X', 8, 'O'])
        expect(game).to be_game_won
      end
    end
  end
end