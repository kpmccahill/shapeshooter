extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal restart_game
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_RetryButton_pressed():
	emit_signal("restart_game")


func _on_QuitButton_pressed():
	var _changed = get_tree().change_scene("res://src/ui/MainMenu.tscn")
