extends Node2D

onready var level = $Level
onready var hud = $HUD
onready var score_label = $HUD/Score
onready var health_bar = $HUD/HealthBar

var regex = RegEx.new()

var score: int = 0

func _ready():
	# score_label.bbcode_text = "[b]" + String(score) + "[/b]"
	score_label.text = String(score)
	level._player.connect("player_death", self, "_on_Player_death")

func _process(_delta: float):
	health_bar.value = level.find_node("Player").health

func _on_Level_child_exiting_tree(node):
	regex.compile("TriangleEnemy")
	var result = regex.search(node.name)
	# print(node.name)
	if result:
		score += 1
		# score_label.bbcode_text = "[b]" + String(score) + "[/b]"
		score_label.text = String(score)


func _on_Player_death():
	score_label.text = "Game over! Final score: " + String(score)
	
