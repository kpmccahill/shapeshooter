extends Node2D

onready var level = $Level
onready var ui = $UI
onready var hud = $UI/HUD
onready var score_label = $UI/HUD/Score
onready var health_bar = $UI/HUD/HealthBar
onready var reset_ui = $UI/ResetOptions
onready var reset_label = $UI/ResetOptions/ResetLabel
onready var pause_menu = $UI/PauseMenu


var regex = RegEx.new()

var score: int = 0
var game_over = false

func _ready():
	score_label.text = String(score)
	level._player.connect("player_death", self, "_on_Player_death")
	level.connect("enemy_death", self, "_on_Enemy_death")

func _process(_delta: float):
	# quits the game on escape
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		pause_menu.visible = !pause_menu.visible
		
	health_bar.value = level.find_node("Player").health

func _on_Enemy_death():
	score += 1
	score_label.text = String(score)

func _on_Player_death():
	game_over = true
	hud.hide()
	reset_ui.show()
	reset_label.text = "Game Over! Final score: " + String(score)
	level.clear_level()


func _on_ResetOptions_restart_game():
	reset_ui.hide()
	hud.show()
	score = 0
	score_label.text = String(score)
	level.new_level()

# func _on_PauseMenu_resume_game():
# 	get_tree().paused = !get_tree().paused
