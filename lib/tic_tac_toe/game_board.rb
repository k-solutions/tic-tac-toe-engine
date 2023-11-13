# frozen_string_literal: true
require 'pry'

module TicTacToe
  # classes to work with game board
  Position = Data.define(:row, :col)
  Move = Data.define(:player, :position)
  ##
  # Game board logic
  class GameBoard
    attr_reader :moves, :players

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

    def empty?(pos)
      !@moves.include? pos
    end

    def evaluate(player)
      cur = evaluate_for_player player
      opp = evaluate_for_player opponent(player)
      cur - opp
    end

    private

    ##
    # Give opponent for a player
    def opponent(player)
      players.first == player ? players.last : players.first
    end

    ##
    # Evaluate Board moves by Player
    def evaluate_for_player(player)
      winning_board_positions.select do |ps|
        row_winning?(ps, player)
      end.size
    end

    ##
    # Game evaluation function is in
    # the form of
    # eval = (number of rows where PLayer win) - (nmb of rows Opponent win)
    def evaluate_position(pos, is_empty: true)
      empty_pos = is_empty ? empty?(pos) : true
      winnig_positions.select do |ps|
        ps.include?(pos) && empty_pos
      end
    end

    def row_winning?(row, player)
      row.all? { |p| p.player.nil? || player == p.player }
    end

    def new_or_existing(pos)
      i = @moves.index { |m| m.position == pos }
      i ? @moves[i] : Move.new(nil, pos)
    end

    def winning_board_positions
      winning_positions.map do |ps|
        ps.map { |p| new_or_existing(p) }
      end
    end

    def winning_positions
      @winning_positions ||=
        begin
          pos = (1..3).to_a
          diag1 = pos.zip(pos)
          diag2 = pos.zip(pos.to_a.reverse)
          rows = pos.map { |p| pos.zip Array.new(3, p) }
          cols = pos.map { |p| Array.new(3, p).zip(pos) }
          ([diag1, diag2] + rows + cols).map do |ps|
            ps.map { |p| Position.new p[0], p[1] }
          end
        end
    end

    def currrent_opponent
      if @first
        @players.last
      else
        @players.first
      end
    end

    def current_player
      if @first
        @players.first
      else
        @players.last
      end
    end

    def next_player
      res = current_player
      @first = !@first
      
      res
    end
  end
end
