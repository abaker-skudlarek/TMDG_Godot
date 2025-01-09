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
	pass # Replace with function body.


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


## Called only from clients
func _on_connection_failed() -> void:
	print("connection failed")


func _host_game() -> void:
	peer = ENetMultiplayerPeer.new()
	var return_code: int = peer.create_server(PORT, MAX_PLAYERS)
	assert(return_code == OK, "Cannot create server: return code: {%s}" % return_code)
	peer.get_host().compress(COMPRESSION_ALGORITHM)
	multiplayer.set_multiplayer_peer(peer)  # This allows us to use our own connection, as the server, making us a "host"
	print("waiting for players to join...")


func _join_game() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(ADDRESS, PORT)
	peer.get_host().compress(COMPRESSION_ALGORITHM)
	multiplayer.set_multiplayer_peer(peer)
