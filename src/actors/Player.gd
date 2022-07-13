# The Player Character
extends Area2D

var win_size  # Initialized on _ready

export var speed: int = 250

# Boost stuff, wanna move this but don't know where
var boost: float
export var boost_max: float
export var boost_modifier: int
export var boost_regen_rate: float # Rate that boost regens
export var boost_deplete_rate: float # Rate that boost depletes

var boost_depleted: bool
var boost_cooldown: int
export var boost_cooldown_max: int # Cooldown is in frames, so 300 frames @ 60fps should be around 5s

# increases the players velocity by the boost_modifier
func use_boost(velocity: Vector2) -> Vector2:
        if not boost_depleted:
                velocity = velocity * boost_modifier
                boost = floor(abs(boost - boost_deplete_rate))
                if boost == 0:
                        boost_depleted = true
        return velocity

# regenerates boost after the cooldown
func regen_boost() -> void:
        if boost_depleted:
                boost_cooldown -= 1
                if boost_cooldown < 1:
                        boost_cooldown = boost_cooldown_max
                        boost_depleted = false
                        boost += boost_regen_rate
        elif boost < 100:
                        boost += boost_regen_rate

func _init() -> void:
        boost_max = 100
        boost_modifier = 2
        boost_regen_rate = 0.5
        boost_deplete_rate = 1.5

        boost_depleted = false
        boost_cooldown_max = 300 # Cooldown is in frames, so 300 frames @ 60fps should be around 5s
        boost_cooldown = boost_cooldown_max

# Called when the node enters the scene tree for the first time.
func _ready():
    win_size = get_viewport_rect().size # Get a Vec2 containing the widow dimensions
    position = win_size / 2 # Position the player at the center of the screen

    boost = boost_max

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
        var velocity = Vector2.ZERO
        if Input.is_action_pressed("move_right"):
                velocity.x += 1
        if Input.is_action_pressed("move_left"):
                velocity.x -= 1
        if Input.is_action_pressed("move_down"):
                velocity.y += 1
        if Input.is_action_pressed("move_up"):
                velocity.y -= 1
                
        # Normalize so that moving diagonally is not faster
        if velocity.length() > 0:
                velocity = velocity.normalized() * speed
        
        print(boost_cooldown)

        print("Boost: ", boost)
        if Input.is_action_pressed("boost"):
                velocity = use_boost(velocity)
        regen_boost()

        print("Velocity: ", velocity.length())

        position += velocity * delta
        position.x = clamp(position.x, 0, win_size.x)
        position.y = clamp(position.y, 0, win_size.y)

