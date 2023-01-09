extends KinematicBody2D

export var speed: int = 750
var velocity = Vector2.ZERO

onready var _player_sprite = $AnimatedSprite
onready var _idle_timer = $IdleTimer

# applies animated sprite to the character. takes in _input_vector but does
# not use it yet.
func _apply_animation(_input_vector: Vector2):
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
		


func _ready():
	_player_sprite.play("idle")

func _physics_process(delta):


	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	input_vector = input_vector.normalized()
	_apply_animation(input_vector)

	velocity += input_vector * speed * delta
	velocity = move_and_slide(velocity, Vector2.ZERO)
	velocity = lerp(velocity, Vector2.ZERO, .1)
	print(velocity)


func _on_IdleTimer_timeout():
	_player_sprite.play("idle")
