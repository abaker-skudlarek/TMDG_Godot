extends Control

const PORT: int = 8910
const ADDRESS: String = "127.0.0.1"
const MAX_PLAYERS: int = 2
const COMPRESSION_ALGORITHM := ENetConnection.COMPRESS_RANGE_CODER

var peer: ENetMultiplayerPeer  # This will become the peer we set up when joining or hosting a game


func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)


func _on_start_game_pressed() -> void:
	_start_game.rpc()


func _on_join_game_pressed() -> void:
	_join_game()


func _on_host_game_pressed() -> void:
	_host_game()


## Called on server and clients when someone connects
func _on_peer_connected(id: int) -> void:
	print("peer {%s} connected" % id)


## Called on server and clients when someone disconnects
func _on_peer_disconnected(id: int) -> void:
	print("peer {%s} disconnected" % id)


## Called only from clients
func _on_connected_to_server() -> void:
	print("connected to server")
	# Call this method only on the server (id = 1), it will call on the rest of the connected players later
	send_player_information.rpc_id(1, %NameLineEdit.text, multiplayer.get_unique_id())


## Called only from clients
func _on_connection_failed() -> void:
	print("connection failed")


func _host_game() -> void:
	# Create server
	peer = ENetMultiplayerPeer.new()
	var return_code: int = peer.create_server(PORT, MAX_PLAYERS)
	assert(return_code == OK, "Cannot create server: return code: {%s}" % return_code)

	# Set peer
	peer.get_host().compress(COMPRESSION_ALGORITHM)
	multiplayer.set_multiplayer_peer(peer)  # This allows us to use our own connection, as the server, making us a "host"
	print("waiting for players to join...")

	# Add host as a player
	send_player_information(%NameLineEdit.text, multiplayer.get_unique_id())


func _join_game() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(ADDRESS, PORT)
	peer.get_host().compress(COMPRESSION_ALGORITHM)
	multiplayer.set_multiplayer_peer(peer)


@rpc("any_peer", "call_local")  # This allows this function to be called on all peers (including local)
func _start_game() -> void:
	# TODO: temporary to get it working. this will need to be done by some sort of scene manager
	var scene: Node = load("res://Scenes/Levels/LevelTest/level_test.tscn").instantiate()
	get_tree().root.add_child(scene)
	hide()


@rpc("any_peer")
func send_player_information(player_name: String, player_id: int) -> void:
	PlayerManager.add_player_to_connected_players(player_name, player_id)

	# If we are the server, call this method on every peer so they get the player information too
	if multiplayer.is_server():
		for key: int in PlayerManager.connected_players:
			var player: Dictionary = PlayerManager.connected_players[key]
			send_player_information.rpc(player.name, player.id)
