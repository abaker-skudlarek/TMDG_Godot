extends Node

@export var spy_scene: PackedScene
@export var agent_scene: PackedScene


func _on_load_both_pressed() -> void:
	load_spy()
	load_agent()


func _on_load_agent_pressed() -> void:
	load_agent()


func _on_load_spy_pressed() -> void:
	load_spy()


func load_spy() -> void:
	var spy: Spy = spy_scene.instantiate()
	spy.position = Globals.spy_spawn_point
	get_tree().root.get_node("Main").add_child.call_deferred(spy)  # TODO: Better way to do this?
	queue_free()


func load_agent() -> void:
	var agent: Agent = agent_scene.instantiate()
	get_tree().root.get_node("Main").add_child.call_deferred(agent)  # TODO: Better way to do this?
	$Menu.hide() 
	queue_free()
