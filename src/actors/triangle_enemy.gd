extends KinematicBody2D

var health := 100

func take_damage(amount: int):
	health -= amount

func _process(_delta):
	if health <= 0:
		print("triangle dead")
