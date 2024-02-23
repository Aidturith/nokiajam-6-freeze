extends Node

func _ready():
	$Character/AnimationPlayer.play('idle')
	$Menu/Container/Food.grab_focus()


func _process(_delta):
	if OS.is_debug_build():
		$Character/Debug.text = Const.STAGE_LABELS[Tama.stage]
	# display trashes
	var poo_added = 0
	for spawn in $SpawnPoints.get_children():
		if poo_added < Tama.nb_poo:
			var poo_s = ResourceLoader.load("res://scene/spawnable/poo.tscn")
			var poo = poo_s.instantiate()
			poo.position = spawn.position
			$Cleanables.add_child(poo)
			poo_added += 1


# hungry system

func feed_meal():
	Tama.add_hungry_heart(Const.HUNGRY_MAX)
	gain_weight(1)

func feed_snack():
	gain_happy_hearts(1)
	gain_weight(2)

func deplete_hungry_hearts(nb: int):
	Tama.hungry = max(0, Tama.hungry - nb)

func gain_happy_hearts(nb: int):
	Tama.happy = min(Const.HAPPY_MAX, Tama.happy + nb)

func gain_weight(kg: int):
	Tama.weight += kg

# sleep system

func sleep():
	Tama.stamina = Const.STAMINA_MAX
	Tama.age += 1
	learn_new_skill()
	evolve()

func learn_new_skill():
	pass

func evolve():
	match Tama.age:
		2:
			Tama.stage = Const.STAGES.BABY
		4:
			Tama.stage = Const.STAGES.CHILD
		7:
			Tama.stage = Const.STAGES.TEEN
		12:
			Tama.stage = Const.STAGES.ADULT

# health system

func heal():
	if Tama.injured:
		Tama.injured = false
		gain_happy_hearts(1)
		deplete_hungry_hearts(2)
		deplete_stamina_gauge(50)

func deplete_stamina_gauge(nb: int):
	Tama.stamina = max(0, Tama.stamina - nb)

# clean system

func clean():
	if Tama.nb_trash or Tama.nb_poo:
		Tama.nb_trash = 0
		Tama.nb_poo = 0
		gain_happy_hearts(1)


func _on_food_pressed():
	if OS.is_debug_build():
		print("feed")
	feed_meal()


func _on_skate_pressed():
	if OS.is_debug_build():
		print("skate")
	Global.goto_scene("res://scene/skate.tscn")


func _on_sleep_pressed():
	if OS.is_debug_build():
		print("sleep")
	sleep()


func _on_cure_pressed():
	if OS.is_debug_build():
		print("cure")
	heal()


func _on_clean_pressed():
	if OS.is_debug_build():
		print("clean")
	clean()


func _on_stats_pressed():
	if OS.is_debug_build():
		print("stats")
	Global.goto_scene("res://scene/stats.tscn")
	
