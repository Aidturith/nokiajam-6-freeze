extends Node2D

enum STAGES {EGG, BABY, CHILD, TEEN, ADULT, FINITO}
const STAGE_LABELS = {
	STAGES.EGG: 'egg',
	STAGES.BABY: 'baby',
	STAGES.CHILD: 'child',
	STAGES.TEEN: 'teen',
	STAGES.ADULT: 'adult',
}

const HAPPY_MAX = 4
const HUNGRY_MAX = 4
const STAMINA_MAX = 100

var age := 0
var weight := 5
var stage := STAGES.EGG
var happy := HAPPY_MAX - 1
var hungry := HUNGRY_MAX - 1
var hungry_gain := 0
var stamina := STAMINA_MAX
var nb_trash := 0
var nb_poo := 0
var injured := false
var warning := false
var mistakes := 0

func _process(_delta):
	$Character/Debug.text = STAGE_LABELS[stage]

# hungry system

func feed_meal():
	gain_hungry_hearts(HUNGRY_MAX)
	gain_weight(1)
	spawn_trash(0.5)

func feed_snack():
	gain_happy_hearts(1)
	gain_weight(2)
	spawn_trash(0.2)

func deplete_hungry_hearts(nb: int):
	hungry = max(0, hungry - nb)

func gain_hungry_hearts(nb: int):
	var hungry_before = hungry
	hungry = min(HUNGRY_MAX, hungry + nb)
	hungry_gain = hungry - hungry_before
	spawn_poo()

func gain_happy_hearts(nb: int):
	happy = min(HAPPY_MAX, happy + nb)

func gain_weight(kg: int):
	weight += kg

func spawn_trash(chance: float):
	if randf() <= chance:
		nb_trash += 1

func spawn_poo():
	if hungry_gain % HUNGRY_MAX == 0:
		nb_poo += 1

# sleep system

func sleep():
	stamina = STAMINA_MAX
	age += 1
	learn_new_skill()

func learn_new_skill():
	pass

# health system

func heal():
	if injured:
		injured = false
		gain_happy_hearts(1)
		deplete_hungry_hearts(2)
		deplete_stamina_gauge(50)

func deplete_stamina_gauge(nb: int):
	stamina = max(0, stamina - nb)

# clean system

func clean():
	if nb_trash or nb_poo:
		nb_trash = 0
		nb_poo = 0
		gain_happy_hearts(1)


func _on_food_pressed():
	print("feed")
	feed_meal()


func _on_skate_pressed():
	print("skate")
	pass


func _on_sleep_pressed():
	print("sleep")
	sleep()


func _on_cure_pressed():
	print("cure")
	heal()


func _on_clean_pressed():
	print("clean")
	clean()


func _on_stats_pressed():
	print("stats")
	pass
