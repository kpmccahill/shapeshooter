extends Node2D

onready var _player: KinematicBody2D = $player
onready var _triangle_enemy = $triangle_enemy
onready var _tilemap = $TileMap

var map_x = 16
var map_y = 16
var map_size = Vector2(map_x, map_y) # size in number of cells

# func spawn_triangle():
# 	var triangle = _triangle_enemy.instance()

func _draw_map():
	for x in range (0, map_x):
		for y in range (0, map_y):
			if x == 0 or x == map_x - 1:
				if (y != 0) and (y != map_y - 1):
					_tilemap.set_cell(x, y, 3)
				else:
					_tilemap.set_cell(x, y, 2)
			elif y == 0 or y == map_y - 1:
				_tilemap.set_cell(x, y, 2)
			else:
				_tilemap.set_cell(x, y, 1)
			
# Called when the node enters the scene tree for the first time.
func _ready():
	_player.position = (map_size * 32) / 2
	_draw_map()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# print(get_children())
	pass
