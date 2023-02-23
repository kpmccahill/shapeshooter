extends Control

# TODO: Add a the ability to hit ESC to unpause. Dunno why it doesnt work.
# probably gonna run into this in the future lol.

func _ready():
	# pause_mode = PAUSE_MODE_PROCESS
	pass

func _on_ResumeButton_pressed():
	hide()
	get_tree().paused = false

func _on_QuitButton_pressed():
	get_tree().paused = !get_tree().paused
	var _changed = get_tree().change_scene("res://src/ui/MainMenu.tscn")
