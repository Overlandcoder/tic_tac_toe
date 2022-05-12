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

  describe '#create_players' do
    before do
      allow(game).to receive(:choose_name)
      allow(game).to receive(:choose_symbol)
      allow(game).to receive(:assign_symbol)
    end

    it 'creates two Players' do
      expect(Player).to receive(:new).twice
      game.create_players
    end
  end

  describe '#choose_name' do
    before do
      allow(game).to receive(:puts)
      allow(game).to receive(:gets).and_return('John')
    end

    it 'sets player name to John' do
      expect(game.choose_name(1)).to eq('John')
    end
  end

  describe '#choose_symbol' do
    context 'when user enters a valid input of X' do
      before do
        valid_symbol = 'X'
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return(valid_symbol)
      end

      it 'stops loop and does not display error message' do
        error_message = 'Invalid symbol, please enter either X or O'
        expect(game).not_to receive(:puts).with(error_message)
        game.choose_symbol
      end
    end

    context 'when user enters an invalid input once, then a valid input' do
      before do
        invalid_symbol = '%'
        valid_symbol = 'O'
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return(invalid_symbol, valid_symbol)
      end

      it 'completes loop and displays error message once' do
        error_message = 'Invalid symbol, please enter either X or O'
        expect(game).to receive(:puts).with(error_message).once
        game.choose_symbol
      end
    end

    context 'when user enters invalid inputs twice, then a valid input' do
      before do
        phrase = 'Hello world!'
        invalid_symbol = '%'
        valid_symbol = 'X'
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return(phrase, invalid_symbol, valid_symbol)
      end

      it 'completes loop and displays error message twice' do
        error_message = 'Invalid symbol, please enter either X or O'
        expect(game).to receive(:puts).with(error_message).twice
        game.choose_symbol
      end
    end
  end
end