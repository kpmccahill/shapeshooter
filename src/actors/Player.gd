# The Player Character
extends Sprite

export var speed = 200
var win_size

# Called when the node enters the scene tree for the first time.
func _ready():
		win_size = get_viewport_rect().size # Get a Vec2 containing the widow dimensions
		position = win_size / 2 # Position the player at the center of the screen


## Input handling
#func _input(event):
#		if event.is_action_pressed("move_right"):
#			position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

        position += velocity * delta
        position.y = clamp(position.x, 0, win_size.x)
        position.x = clamp(position.x, 0, win_size.x)
