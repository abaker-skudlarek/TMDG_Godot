extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MultiplayerID.text = "ID: %s" % str(multiplayer.get_unique_id())



