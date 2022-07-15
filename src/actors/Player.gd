# The Player Character
extends Area2D

var win_size  # Initialized on _ready

export var speed: int = 250

# Health stuff
export var max_health: int = 5
var health: int = max_health

# Boost stuff, wanna move this but don't know where
export var boost_max := 100
export var boost_modifier: int = 2
export var boost_regen_rate := 1 # Rate that boost regens
export var boost_deplete_rate: int = 2 # Rate that boost depletes
var boost: float = boost_max

# Cooldown stuff
export var boost_cooldown_max: int = 300 # Cooldown is in frames, so 300 frames @ 60fps should be around 5s
var boost_cooldown: int = boost_cooldown_max

# State for the boost
enum BoostState {REGEN, COOLDOWN}
var boost_state = BoostState.REGEN

signal boost_cooldown
signal boost_regen

# increases the players velocity by the boost_modifier
func use_boost(velocity: Vector2) -> Vector2:
        velocity = velocity * boost_modifier
        boost = abs(boost - boost_deplete_rate)
        if boost == 0:
                boost_state = BoostState.COOLDOWN
                $BoostCooldown.start()
                emit_signal("boost_cooldown")
        return velocity

# regenerates boost
func regen_boost() -> void:
        if boost < boost_max:
                boost += boost_regen_rate

# Called when the node enters the scene tree for the first time.
func _ready():
    win_size = get_viewport_rect().size # Get a Vec2 containing the widow dimensions
    position = win_size / 2 # Position the player at the center of the screen
    $BoostCooldown.set_wait_time(boost_cooldown_max / 60)
    $BoostCooldown.set_one_shot(true)

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
        
        if Input.is_action_pressed("boost"):
                if boost_state != BoostState.COOLDOWN:
                        velocity = use_boost(velocity)

        if boost_state == BoostState.REGEN:
                regen_boost()
        
        print("boost: ", boost)
        print("timer: ", $BoostCooldown.time_left)
        position += velocity * delta
        position.x = clamp(position.x, 0, win_size.x)
        position.y = clamp(position.y, 0, win_size.y)

# Switches to COOLDOWN state when the boost is empty
func _on_Area2D_boost_cooldown():
        boost_state = BoostState.COOLDOWN
        yield($BoostCooldown, "timeout")

# Switches back to REGEN state
func _on_BoostCooldown_timeout():
        boost_state = BoostState.REGEN
        emit_signal("boost_regen")
