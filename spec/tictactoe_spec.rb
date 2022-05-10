require './lib/tic_tac_toe.rb'

describe Game do
  subject(:game) { described_class.new }

  describe '#game_won?' do
    context 'when symbol is X' do
      let(:player1) { double(Player, name: 'John', symbol: 'X') }

      before do
        allow(game).to receive(:current_player).and_return(player1)
      end

      it 'returns true when game_won? for top row' do
        game.mark(1)
        game.mark(2)
        game.mark(3)
        expect(game).to be_game_won
      end
    end
  end
end