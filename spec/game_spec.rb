require_relative '../lib/game'

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

  describe '#valid_symbol?' do
    context 'when given a valid input as argument' do
      it 'returns true' do
        symbol = 'X'
        expect(game.valid_symbol?(symbol)).to be true
      end
    end

    context 'when given an invalid input as argument' do
      it 'returns false' do
        invalid_symbol = 'ab'
        expect(game.valid_symbol?(invalid_symbol)).to be false
      end
    end
  end

  describe '#assign_symbol' do
    context 'when player1 symbol is X' do
      let(:player1) { double(Player, name: 'John', symbol: 'X') }

      it 'returns O when player1 symbol is X' do
        game.instance_variable_set(:@player1, player1)
        expect(game.assign_symbol).to eq('O')
      end
    end

    context 'when player2 symbol is O' do
      let(:player1) { double(Player, name: 'John', symbol: 'O') }

      it 'returns X when player1 symbol is O' do
        game.instance_variable_set(:@player1, player1)
        expect(game.assign_symbol).to eq('X')
      end
    end
  end

  describe '#play_game' do
    let(:player1) { double(Player, name: 'John', symbol: 'X') }

    context 'when game_over? is false five times' do
      before do
        allow(game).to receive(:setup)
        allow(game).to receive(:game_over?).and_return(false, false, false, false, false, true)
        allow(game).to receive(:puts)
        allow(game).to receive(:current_player).and_return(player1)
        allow(game).to receive(:valid_move?).and_return(true)
        game.instance_variable_set(:@player1, player1)
      end

      it 'calls #switch_turns five times' do
        expect(game).to receive(:switch_turns).exactly(5).times
        game.play_game
      end

      it 'calls #display_board six times' do
        expect(game).to receive(:display_board).exactly(6).times
        game.play_game
      end

      it 'calls #solicit_move five times' do
        allow(game).to receive(:mark)
        expect(game).to receive(:solicit_move).exactly(5).times
        game.play_game
      end

      it 'calls #mark five times' do
        expect(game).to receive(:mark).exactly(5).times
        game.play_game
      end

      it 'calls #conclusion once' do
        expect(game).to receive(:conclusion).once
        game.play_game
      end
    end
  end

  describe '#mark' do
    let(:player1) { double(Player, name: 'John', symbol: 'X') }

    before do
      allow(game).to receive(:current_player).and_return(player1)
    end

    it 'marks a position with X' do
      positions = game.instance_variable_get(:@positions)
      expect(positions[1]).to eq(2)
      game.mark(2)
    end
  end

  describe '#solicit_move' do
    let(:player1) { double(Player, name: 'John', symbol: 'X') }

    context 'when given a valid move as input' do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:current_player).and_return(player1)
        allow(game).to receive(:gets).and_return('1')
      end
      
      it 'returns the input' do
        expect(game.solicit_move).to eq(1)
      end

      it 'does not call #solicit_move again' do
        expect(game).not_to receive(:solicit_move)
      end
    end

    context 'when given a number not included on the board as input' do
      before do
        allow(game).to receive(:current_player).and_return(player1)
        allow(game).to receive(:gets).and_return('100')
      end

      it 'calls #solicit_move again' do
        expect(game).to receive(:solicit_move).once
        game.solicit_move
      end
    end

    context 'when given a letter as input' do
      before do
        allow(game).to receive(:current_player).and_return(player1)
        allow(game).to receive(:gets).and_return('A')
      end

      it 'calls #solicit_move again' do
        expect(game).to receive(:solicit_move).once
        game.solicit_move
      end
    end
  end

  describe '#valid_move?' do
    context 'when given a valid move as input' do
      it 'returns true' do
        expect(game.valid_move?(1)).to be true
      end
    end

    context 'when given a number not included on the board as input' do
      before do
        allow(game).to receive(:puts)
      end

      it 'returns false' do
        expect(game.valid_move?(100)).not_to be true
      end
    end

    context 'when given a word as input' do
      before do
        allow(game).to receive(:puts)
      end

      it 'returns false' do
        expect(game.valid_move?('word')).not_to be true
      end
    end
  end
end
