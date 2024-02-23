extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_infinite_ice_rink()

func update_infinite_ice_rink():
	if int($Player.position.z) - int($IceRink.position.z) == 16:
		$IceRink.position.z += 16
	if int($Player.position.z) - int($IceRink.position.z) == -16:
		$IceRink.position.z -= 16
	if int($Player.position.x) - int($IceRink.position.x) == 16:
		$IceRink.position.x += 16
	if int($Player.position.x) - int($IceRink.position.x) == -16:
		$IceRink.position.x -= 16


# func _input(event):
	# if()
