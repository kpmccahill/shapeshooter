extends KinematicBody2D

# movement vars
export var speed: int = 750
var velocity = Vector2.ZERO

# health 

onready var _player_sprite = $AnimatedSprite
onready var _idle_timer = $IdleTimer
onready var _projectile = preload("res://src/particles/square_projectile.tscn")

# applies animated sprite to the character. takes in _input_vector but does
# not use it yet.
func _apply_animation():
	# print(input_vector.length())

	# applies the horizontal movement sprite before the vertical, so moving
	# in a diagonal direction uses the l/r sprite rather than u/d
	# TODO: fix this. Add a diagonal sprite?
	if Input.is_action_pressed("move_right"):
		_player_sprite.play("move_right")
		_idle_timer.start()
	elif Input.is_action_pressed("move_left"):
		_player_sprite.play("move_left")
		_idle_timer.start()
	elif Input.is_action_pressed("move_down"):
		_player_sprite.play("move_down")
		_idle_timer.start()
	elif Input.is_action_pressed("move_up"):
		_player_sprite.play("move_up")
		_idle_timer.start()
		

func _fire_projectile():
	var instanced_projectile = _projectile.instance()

	var mouse_pos = get_local_mouse_position()
	mouse_pos = mouse_pos.normalized()	

	# creating the offset, could just do 10, 10 but eh
	var offset_value = 10
	var offset = Vector2(offset_value, offset_value)

	# offset the projectile so it comes from just outside player
	instanced_projectile.position = position + (offset * mouse_pos)
	instanced_projectile.velocity = mouse_pos * instanced_projectile.velocity
	# need to multiply the velocity by the normalized mouse pos to get direction of travel
	
	# MUST add this to the owner! otherwise position gets all fucky.
	owner.add_child(instanced_projectile)


func _ready():
	_player_sprite.play("idle")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	# normalize vector so diagnonal movement isn't faster
	input_vector = input_vector.normalized()

	# apply animation based on input direction.
	_apply_animation()

	# apply speed to the direction from input vector, adding in delta for frames
	velocity += input_vector * speed * delta
	velocity = move_and_slide(velocity, Vector2.ZERO)
	velocity = lerp(velocity, Vector2.ZERO, .1)

	if Input.is_action_just_pressed("shoot_projectile"):
		_fire_projectile()

func _on_IdleTimer_timeout():
	_player_sprite.play("idle")
