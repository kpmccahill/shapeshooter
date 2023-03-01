extends Node2D

onready var level = $Level
onready var ui = $UI
onready var hud = $UI/HUD
onready var score_label = $UI/HUD/Score
onready var health_bar = $UI/HUD/HealthBar
onready var reset_ui = $UI/ResetOptions
onready var reset_label = $UI/ResetOptions/ResetLabel
onready var pause_menu = $UI/PauseMenu

onready var audio_player = $AudioStreamPlayer
onready var projectile_audio_player = $ProjectileStreamPlayer
var player_hurt_sound = preload("res://assets/sounds/player_hurt_sound.wav")
var player_fire_projectile = preload("res://assets/sounds/player_fire_projectile.wav")
var enemy_hurt_sound = preload("res://assets/sounds/enemy_hurt_sound.wav")
var enemy_death_sound = preload("res://assets/sounds/enemy_death_sound.wav")


var regex = RegEx.new()

var score: int = 0
var game_over = false

func _ready():
	score_label.text = String(score)
	level._player.connect("player_damaged", self, "_on_Player_damaged")
	level._player.connect("player_death", self, "_on_Player_death")
	level._player.connect("player_fired", self, "_on_Player_fired")
	level.connect("enemy_damaged", self, "_on_Enemy_damaged")
	level.connect("enemy_death", self, "_on_Enemy_death")

func _process(_delta: float):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		pause_menu.visible = !pause_menu.visible
		
	health_bar.value = level.find_node("Player").health

func _on_Player_damaged():
	$AudioStreamPlayer.stream = player_hurt_sound
	$AudioStreamPlayer.play()

func _on_Enemy_damaged():
	$AudioStreamPlayer.stream = enemy_hurt_sound
	$AudioStreamPlayer.play()

func _on_Player_death():
	game_over = true
	hud.hide()
	reset_ui.show()
	reset_label.text = "Game Over! Final score: " + String(score)
	level.clear_level()

func _on_Enemy_death():
	$AudioStreamPlayer.stream = enemy_death_sound
	$AudioStreamPlayer.play()
	score += 1
	score_label.text = String(score)

func _on_Player_fired():
	$ProjectileStreamPlayer.stream = player_fire_projectile
	$ProjectileStreamPlayer.play()

func _on_ResetOptions_restart_game():
	reset_ui.hide()
	hud.show()
	score = 0
	score_label.text = String(score)
	level.new_level()
