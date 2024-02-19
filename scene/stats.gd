extends Node

func _ready():
	var values = {
		'age': Tama.age,
		'weight': Tama.weight,
		'hungry': Tama.hungry,
		'happy': Tama.happy,
		'tricks': "N/A",
		'medals': "N/A",
		'mistakes': Tama.mistakes,
		'nb_trash': Tama.nb_trash,
		'nb_poo': Tama.nb_poo,
	}
	$Menu/Scroll/Container/Age.text = "Age : {age} years".format(values)
	$Menu/Scroll/Container/Weight.text = "Weight : {weight} kg".format(values)
	$Menu/Scroll/Container/Hungry.text = "Hungry : {hungry}".format(values)
	$Menu/Scroll/Container/Happy.text = "Happy : {happy}".format(values)
	$Menu/Scroll/Container/Tricks.text = "Tricks {tricks}".format(values)
	$Menu/Scroll/Container/Medals.text = "Medals {medals}".format(values)
	$Menu/Scroll/Container/Mistakes.text = "_mistakes {mistakes}".format(values)
	$Menu/Scroll/Container/NbTrash.text = "_trash {nb_trash}".format(values)
	$Menu/Scroll/Container/NbPoo.text = "_poo {nb_poo}".format(values)
	if not OS.is_debug_build():
		for node in get_tree().get_nodes_in_group('debug'):
			node.visible = false

func _process(_delta):
	if Input.is_action_pressed('ui_down'):
		$Menu/Scroll.scroll_vertical += 10
	elif Input.is_action_just_released('ui_up'):
		$Menu/Scroll.scroll_vertical -= 10
	elif Input.is_action_pressed('ui_cancel'):
		Global.goto_scene('res://scene/stats.tscn')
