extends Node

var connected_players := {}


func add_player_to_connected_players(player_name: String, player_id: int) -> void:
	# TODO: if the player id is already in the list, maybe we should check to see if the 
	# 		sent in information is different, and if it is, update it
	if connected_players.has(player_id):
		return
	connected_players[player_id] = {
		"name": player_name,
		"id": player_id
	}
	print("{%s} (id: {%s}) added to connected_players" % [player_name, player_id])