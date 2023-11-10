# frozen_string_literal: true

module TicTacToe
  # classes to work with game board
  Position = Data.define(:row, :col)
  Move = Data.define(:player, :position)
  ##
  # Game board logic
  class GameBoard
    attr_reader :moves

    def self.default_players
      %w[X O]
    end

    def initialize(players: GameBoard.default_players)
      @first = true
      @players = players
      @moves = []
    end

    def next_move(position:)
      @moves << Move.new(next_player, position)
      self
    end

    def prev_move
      @moves.pop
      self
    end

    private

    def next_player
      if @first
        @players[0]
      else
        @players[1]
      end
      @first = !@first
    end
  end
end
