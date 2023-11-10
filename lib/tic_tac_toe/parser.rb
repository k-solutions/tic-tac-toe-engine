# frozen_string_literal: true

require 'yaml'
require 'ostruct'
require_relative 'game_board'

# file = "data/game1.yaml"
module TicTacToe
  ##
  # Parses file and create GameBoard
  module Parser
    def from_file(file)
      data = YAML.safe_load_file(file, symbolize_names: true, permitted_classes: [Symbol, OpenStruct])
      game_board = GameBoard.new(players: data[:players])
      data[:moves].each do |move|
        game_board.next_move(position: Position.new(move.row, move.col))
      end
      game_board
    end
    module_function :from_file
  end
end
