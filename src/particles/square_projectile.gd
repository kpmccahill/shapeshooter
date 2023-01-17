extends Node2D


export var damage := 10
onready var _timer = $AliveTimer
var velocity = Vector2.ZERO

func _ready():
	_timer.wait_time = 2
	_timer.start()

func _process(delta):
	position += velocity * delta

func _on_AliveTimer_timeout():
	queue_free()
