extends Node2D

onready var level = $Level
onready var hud = $HUD
onready var score_label = $HUD/Score
onready var health_bar = $HUD/HealthBar
onready var reset_label = $HUD/ResetTimer


var regex = RegEx.new()

var score: int = 0

func _ready():
	# score_label.bbcde()

	score_label.text = String(score)
	level._player.connect("player_death", self, "_on_Player_death")
	level.connect("enemy_death", self, "_on_Enemy_death")

func _process(_delta: float):
	
	# quits the game on escape
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	health_bar.value = level.find_node("Player").health
	print($ResetTimer.time_left)

	if not $ResetTimer.is_stopped():
		reset_label.text = "Level reset in: " + String(int($ResetTimer.time_left))

# func _on_Level_child_exiting_tree(node):
# 	regex.compile("TriangleEnemy")
# 	var result = regex.search(node.name)
# 	# print(node.name)
# 	if result:
# 		score += 1
# 		# score_label.bbcode_text = "[b]" + String(score) + "[/b]"
# 		score_label.text = String(score)

func _on_Enemy_death():
	score += 1
	score_label.text = String(score)

func _on_Player_death():
	score_label.text = "Game over! Final score: " + String(score)
	level.clear_level()
	$ResetTimer.start()

func _on_ResetTimer_timeout():
	reset_label.text = ""
	score = 0
	score_label.text = String(score)
	level.new_level()
