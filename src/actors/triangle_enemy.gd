extends KinematicBody2D


var health := 100

func take_damage(amount: int):
	health -= amount
