extends Node

var age := 0
var weight := 5
var stage := Const.STAGES.EGG
var happy := Const.HAPPY_MAX - 1
var hungry := Const.HUNGRY_MAX - 1
var hungry_hearts_added := 0
var stamina := Const.STAMINA_MAX
var nb_trash := 0
var nb_poo := 0
var injured := false
var warning := false
var mistakes := 0

func add_hungry_heart(to_add: int):
    var maxed = min(Const.HUNGRY_MAX, hungry + to_add)
    var added = maxed - hungry
    if added == 0:
        return
    hungry_hearts_added += added
    hungry = maxed
    spawn_poo()

func spawn_poo():
    if hungry_hearts_added % Const.HUNGRY_MAX == 0:
        nb_poo += 1
