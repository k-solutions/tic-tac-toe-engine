module TicTacToe
  
  Position = Data.define(:row, :col) 
  Move = Data.define(:player, :position)

  class GameBoard
    attr_reader :moves

    def self.default_players ["X", "O"] end 
    
    def initialize(players: self.default_player)
      @first = true
      @players = players
      @moves = []
    end
    
    def nextMove(:position)
       
    end

    def prev_move()
    end  
  end  
end  
