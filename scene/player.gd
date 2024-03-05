extends CharacterBody3D

@onready var animation_tree = %AnimationTree

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# func _ready():
	# $AnimationPlayer.play('idle')


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		# velocity.x = direction.x * SPEED
		# velocity.z = direction.z * SPEED
		velocity.x = move_toward(velocity.x, direction.x * SPEED * 2, SPEED / 100)
		velocity.z = move_toward(velocity.z, direction.z * SPEED * 2, SPEED / 100)
		# print(transform.basis.x)
		# print(Vector3(direction.x, 0 , 0))
		# transform.basis.x += Vector3(direction.x, 0 , 0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / 300)
		velocity.z = move_toward(velocity.z, 0, SPEED / 300)
	
	# rotate
	# rotation.y = atan2(velocity.x, velocity.z)
	# print(rotation.y)

	move_and_slide()
	update_state()
	

func update_state():
	var skating = is_skating()
	var sliding = is_sliding()
	var idle = is_idle()
	animation_tree.set("parameters/conditions/skating", skating)
	animation_tree.set("parameters/conditions/sliding", sliding)
	animation_tree.set("parameters/conditions/idle", idle)
	animation_tree.set("parameters/skate_speed/TimeScale/scale", velocity.length() / 2)

func is_skating():
	if Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down"):
		return true
	return false

func is_sliding():
	if velocity and not is_skating():
		return true
	return false

func is_idle():
	return not is_sliding()