extends Node

var current_scene = null

func _ready():
	current_scene = screen_node().get_child(0)

func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path):
	current_scene.free()
	var scene = ResourceLoader.load(path)
	current_scene = scene.instantiate()
	screen_node().add_child(current_scene)

func screen_node():
	return get_tree().root.get_node('/root/Main/SubViewportContainer/Screen')