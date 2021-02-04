extends KinematicBody2D
var root

# KNOBS!
# To make any variable editor-adjustable,
# export it; provide a default value, a type, or both

# Motion
export (int) var speed = 300
export (float) var friction = 0.04
export (float) var acceleration = 0.1

# Damage/healing
export (float) var health_decay_rate = 25
export (float) var health_decay_delay = 0 # not implemented yet
export (float) var health_recharge_rate = 1
export (float) var health_recharge_delay = 0 # not implemented yet

# Track whether we're close enough to haunt something
var nearby_hauntable = null

# Velocity is for physics; to change ghost speed, edit the speed var
var velocity = Vector2.ZERO
var input_velocity = Vector2.ZERO

# Translate user inputs into a velocity
func get_movement_input():
	input_velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"): 
		input_velocity.x += 1
		$body.scale.x = 1
	if Input.is_action_pressed("move_left"):
		input_velocity.x -= 1 
		$body.scale.x = -1
	if Input.is_action_pressed("move_down"): input_velocity.y += 1
	if Input.is_action_pressed("move_up"): input_velocity.y -= 1
	input_velocity = input_velocity.normalized() * speed

# Move the character based on the current input_velocity
func handle_movement(_delta):
	if input_velocity.length() > 0:
#		set_motion_state(motion_states.MOVING)
		velocity = velocity.linear_interpolate(input_velocity, acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
#		set_motion_state(motion_states.IDLE)
	velocity = move_and_slide(velocity)

# called every frame
func _physics_process(_delta):
	get_movement_input()
	handle_movement(_delta)

func _ready():
	set_physics_process(true)
