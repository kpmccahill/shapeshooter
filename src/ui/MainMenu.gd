extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _on_PlayButtton_pressed():
	var _changed = get_tree().change_scene("res://src/Main.tscn")


func _on_QuitButton_pressed():
	get_tree().quit() 
