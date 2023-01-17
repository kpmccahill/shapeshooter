# projectile code for the player char
extends Node2D


export var damage := 10

onready var _timer = $AliveTimer
onready var _animation_player = $AnimationPlayer

# projectile movement vars
var velocity = Vector2.ONE
export var speed = 700

func _ready():

	# start timer to despawn the projectile
	_timer.wait_time = 2
	_timer.start()

	# start the spinning animation
	_animation_player.playback_speed = 2.0
	_animation_player.play("spin")

	# apply speed to velocity, direction comes from player (defaults down and right)
	velocity = speed * velocity

func _process(delta):
	position += velocity * delta 

func _on_AliveTimer_timeout():
	queue_free()
