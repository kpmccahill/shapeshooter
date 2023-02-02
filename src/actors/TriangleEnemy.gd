extends KinematicBody2D

var health := 100

var speed = 500
var velocity = Vector2.ZERO
var target = null

signal death

func take_damage(amount: int):
	health -= amount


func _process(delta):
	var movement_direction = Vector2()
	if health <= 0:
		emit_signal("death")
		queue_free()

	if target:
		movement_direction = global_position.direction_to(target.global_position)
	
	movement_direction = movement_direction.normalized()
	velocity += movement_direction * speed * delta
	velocity = move_and_slide(velocity, Vector2.ZERO)

func _on_PlayerDetection_body_entered(body: Node):
	if body.name == "Player":
		target = body
