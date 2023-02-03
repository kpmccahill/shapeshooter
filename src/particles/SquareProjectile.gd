# projectile code for the player char
extends Node2D


export var damage := 25

onready var _timer = $AliveTimer
onready var _animation_player = $AnimationPlayer
onready var _hitbox = $Sprite/Hitbox

# projectile movement vars
var velocity = Vector2.ONE
export var speed = 700

func _ready():

	# start timer to despawn the projectile
	_timer.wait_time = .5
	_timer.start()

	# start the spinning animation
	_animation_player.playback_speed = 2.0
	_animation_player.play("spin")

	# apply speed to velocity, direction comes from player (defaults down and right)
	velocity = speed * velocity

	# override the default damage for hitboxes
	_hitbox.damage = damage

func _process(delta):
	position += velocity * delta

func _on_AliveTimer_timeout():
	queue_free()

func _on_Hitbox_area_entered(area: Area2D):
	if area.name != "Hurtbox":
		queue_free()
