extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# signal resume_game
# var paused = false
# func _input(event):
# 	if event.is_action_pressed("ui_cancel") && get_parent().get_tree().paused:
# 		get_parent().get_tree().paused = false
# 		hide()
# 		print(get_tree().paused)
# func _process(_delta):
# 	if Input.is_action_just_pressed("ui_cancel"):
# 		hide()
# 		paused = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = PAUSE_MODE_PROCESS

func _on_ResumeButton_pressed():
	hide()
	get_tree().paused = false
	# emit_signal("resume_game")

func _on_QuitButton_pressed():
	get_tree().paused = !get_tree().paused
	var _changed = get_tree().change_scene("res://src/ui/MainMenu.tscn")


# func _on_PauseMenu_visibility_changed():
# 	if visible:
# 		grab_focus()
# 	else:
# 		release_focus()
