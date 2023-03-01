extends KinematicBody2D

onready var animation_player = $AnimationPlayer
onready var hitbox1 = $AnimatedSprite/EnemyHitbox
onready var hitbox2 = $AnimatedSprite/EnemyHitbox2
onready var hitbox3 = $AnimatedSprite/EnemyHitbox3

var health := 100

var speed = 500
var velocity = Vector2.ZERO
var target = null

export var damage := 20
signal enemy_damaged
signal death

func take_damage(amount: int):
	emit_signal("enemy_damaged")
	health -= amount


func _ready():
	hitbox1.damage = damage
	hitbox2.damage = damage
	hitbox3.damage = damage

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

	if velocity.abs() > Vector2.ONE:
		animation_player.play("Spin")

func _on_PlayerDetection_body_entered(body: Node):
	if body.name == "Player":
		target = body
