# frozen_string_literal: true

require 'yaml'
require 'ostruct'
require 'pry'
require_relative '../../lib/tic_tac_toe/parser'

RSpec.describe TicTacToe::Parser do
  let(:test_file) { 'data/game1.yaml' }

  describe '#from_file' do
    context 'when the file contains valid data' do
      let(:valid_data) do
        {
          players: %w[X O],
          moves: [TicTacToe::Position.new(1, 1), TicTacToe::Position.new(2, 2), TicTacToe::Position.new(3, 1)]
        }
      end

      before do
        allow(YAML).to receive(:safe_load_file).with(test_file, symbolize_names: true, permitted_classes: [Symbol, OpenStruct]).and_return(valid_data)
      end

      it 'creates a GameBoard with correct players and moves' do
        expect(TicTacToe::GameBoard).to receive(:new).with(players: valid_data[:players]).and_call_original
        game_board = TicTacToe::Parser.from_file(test_file)
        expect(game_board.moves.length).to eq(valid_data[:moves].length)
        expect(game_board.instance_variable_get(:@players)).to eq(valid_data[:players])
      end
    end

    context 'when the file contains invalid data' do
      let(:invalid_data) do
        {
          players: %w[A B], # Invalid players
          moves: [{ row: 1, col: 1 }, { row: 2, col: 2 }, { row: 3, col: 1 }]
        }
      end

      before do
        allow(YAML).to receive(:safe_load_file).with(test_file, symbolize_names: true, permitted_classes: [Symbol, OpenStruct]).and_return(invalid_data)
      end

      it 'raises an error' do
        expect { TicTacToe::Parser.from_file(test_file) }.to raise_error(StandardError)
      end
    end

    context 'when the file does not exist' do
      before do
        allow(YAML).to receive(:safe_load_file).and_raise(Errno::ENOENT)
      end

      it 'raises an error' do
        expect { TicTacToe::Parser.from_file(test_file) }.to raise_error(Errno::ENOENT)
      end
    end
  end
end
