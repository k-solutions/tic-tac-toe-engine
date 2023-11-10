require 'yaml'
require 'ostruct'

# class Move < Struct.new('Move', :)
move = OpenStruct.new(player: "X", row: 1, col: 1)

# game_move = GameMove.new player: "X", row: 1, col: 1

puts move.to_yaml 

file = "data/game1.yaml"
data = YAML.safe_load_file(file, symbolize_names: true, permitted_classes: [Symbol, OpenStruct])

puts "Game: #{data[:game]}"
puts "Players: #{data[:players]}"
puts "Moves: #{data[:moves]}"
