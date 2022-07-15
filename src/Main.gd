# Main scene, connect everything together.
extends Node2D

onready var hud = get_node("hud")
onready var player = get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
        hud.update_resource_meter(hud.get_node("BoostMeter"), player.boost)

        if hud.get_node("BoostCooldown").is_visible():
                hud.update_text_element(hud.get_node("BoostCooldown"), player.get_node("BoostCooldown").time_left)

func _on_Player_boost_cooldown():
        hud.get_node("BoostCooldown").show()

func _on_Player_boost_regen():
        hud.get_node("BoostCooldown").hide()
