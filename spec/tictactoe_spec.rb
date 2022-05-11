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

    context 'when game is tied' do
      it 'is not game_won' do
        game.instance_variable_set(:@positions, ['X', 'O', 'X', 'O', 'X', 'O', 'O', 'X', 'O'])
        expect(game).not_to be_game_won
      end
    end

    context 'when game is new' do
      it 'is not game_won' do
        expect(game).not_to be_game_won
      end
    end
  end

  describe '#game_tied?' do
    context 'when all positions have been marked and game is not won' do
      it 'is game_tied' do
        game.instance_variable_set(:@positions, ['X', 'O', 'X', 'O', 'X', 'O', 'O', 'X', 'O'])
        expect(game).to be_game_tied
      end
    end

    context 'when game has been won' do
      it 'is not game_tied' do
        game.instance_variable_set(:@positions, ['X', 'X', 'X', 'O', 'X', 6, 7, 'O', 'O'])
        expect(game).not_to be_game_tied
      end
    end

    context 'when all positions have been marked and game has been won' do
      it 'is not game_tied' do
        game.instance_variable_set(:@positions, ['X', 'O', 'X', 'O', 'X', 'O', 'O', 'X', 'X'])
        expect(game).not_to be_game_tied
      end
    end
  end
end