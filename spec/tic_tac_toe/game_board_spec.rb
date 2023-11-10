# frozen_string_literal: true

require_relative '../../lib/tic_tac_toe/game_board'
require 'pry'

RSpec.describe TicTacToe::GameBoard do
  let(:game_board) { TicTacToe::GameBoard.new }

  describe '#initialize' do
    it 'creates a GameBoard with default players' do
      expect(game_board.moves).to be_empty
      expect(game_board.instance_variable_get(:@players)).to eq(%w[X O])
    end

    it 'creates a GameBoard with custom players' do
      custom_players = %w[A B]
      custom_game_board = TicTacToe::GameBoard.new(players: custom_players)
      expect(custom_game_board.instance_variable_get(:@players)).to eq(custom_players)
    end
  end

  describe '#next_move' do
    it 'adds a move to the board' do
      position = TicTacToe::Position.new(1, 1)
      game_board.next_move(position: position)
      expect(game_board.moves).to contain_exactly(an_instance_of(TicTacToe::Move))
    end

    it 'alternates between players' do
      position1 = TicTacToe::Position.new(1, 1)
      position2 = TicTacToe::Position.new(2, 2)

      # puts game_board.moves
      game_board.next_move(position: position1)

      expect(game_board.moves.last.player).to eq('X')

      game_board.next_move(position: position2)
      expect(game_board.moves.last.player).to eq('O')
    end
  end

  describe '#prev_move' do
    it 'removes the last move from the board' do
      position = TicTacToe::Position.new(1, 1)
      game_board.next_move(position: position)
      expect { game_board.prev_move }.to change { game_board.moves.length }.by(-1)
    end
  end
end