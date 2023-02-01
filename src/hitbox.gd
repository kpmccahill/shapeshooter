class_name Hitbox
extends Area2D

# this must be overridden by the class that implements this hitbox
# in order to have accurate damage.
export var damage := 0
func _init():
	collision_layer = 2
	collision_mask = 0
