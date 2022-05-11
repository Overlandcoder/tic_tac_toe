require './lib/game.rb'

describe Game do
  subject(:game) { described_class.new }

  describe '#game_over?' do
    context 'when all elements in top row are X' do      
      it 'is game_over' do
        game.instance_variable_set(:@positions, ['X', 'X', 'X', 'O', 'X', 6, 7, 'O', 'O'])
        expect(game).to be_game_over
      end
    end

    context 'when all elements in middle column are X' do
      it 'is game_over' do
        game.instance_variable_set(:@positions, ['O', 'X', 3, 4, 'X', 6, 'O', 'X', 'O'])
        expect(game).to be_game_over
      end
    end

    context 'when all elements in a diagonal are O' do
      it 'is game_over' do
        game.instance_variable_set(:@positions, ['O', 'X', 3, 4, 'O', 'X', 'X', 8, 'O'])
        expect(game).to be_game_over
      end
    end

    context 'when all positions have been marked and game is not won' do
      it 'is game_over' do
        game.instance_variable_set(:@positions, ['X', 'O', 'X', 'O', 'X', 'O', 'O', 'X', 'O'])
        expect(game).to be_game_over
      end
    end

    context 'when game is new' do
      it 'is not game_over' do
        expect(game).not_to be_game_over
      end
    end

    context 'when only a few positions have been marked' do
      it 'is not game_over' do
        game.instance_variable_set(:@positions, ['1', 'X', 3, 4, 5, 'O', 7, 'O', 9])
        expect(game).not_to be_game_over
      end
    end
  end
end