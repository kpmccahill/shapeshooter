extends Node2D

onready var level = $Level
onready var hud = $HUD
onready var score_label = $HUD/Score

var regex = RegEx.new()

var score: int = 0

func _ready():
	# score_label.bbcode_text = "[b]" + String(score) + "[/b]"
	score_label.text = String(score)

func _process(_delta: float):
	pass

func _on_Level_child_exiting_tree(node):
	regex.compile("TriangleEnemy")
	var result = regex.search(node.name)
	print(node.name)
	if result:
		score += 1
		# score_label.bbcode_text = "[b]" + String(score) + "[/b]"
		score_label.text = String(score)

# func _on_TriangleEnemy_death():
# 	score += 1
# 	score_label.text = String(score)
