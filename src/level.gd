extends Node2D

export(PackedScene) var triangle_scene

onready var _player: KinematicBody2D = $Player
onready var _tilemap = $TileMap
onready var _spawn_path = $Path2D
# onready var camera = $Camera2D

var map_x = 24
var map_y = 24
var map_size = Vector2(map_x, map_y) # size in number of cells

func create_triangle():
	var location = $Path2D/PathFollow2D
	location.offset = randi()
	# print(location.offset)

	var spawned_enemy = triangle_scene.instance()
	spawned_enemy.position = location.position
	add_child(spawned_enemy)

# spawns enemy triangle(s)
func spawn_triangle():
	randomize()
	var chance = randi() % 10
	# print(chance)
	if chance < 8:
		if chance > 4:
			create_triangle()
			create_triangle()
		else:
			create_triangle()

# draws the map and borders according to map_x and map_y
func _draw_map():
	for x in range (0, map_x):
		for y in range (0, map_y):
			# if is is a l or r edge draw vert border
			if x == 0 or x == map_x - 1:
				if (y != 0) and (y != map_y - 1):
					_tilemap.set_cell(x, y, 3)
				else:
					_tilemap.set_cell(x, y, 2)
			# if it is a top or bottom edge draw hor border
			elif y == 0 or y == map_y - 1:
				_tilemap.set_cell(x, y, 2)
			# else draw floor
			else:
				_tilemap.set_cell(x, y, 1)

	# creates spawn possibility space
	var min_x = 2 * 32
	var min_y = 2 * 32
	var max_x = (map_x - 2) * 32
	var max_y = (map_y - 2) * 32
	_spawn_path.curve.add_point(Vector2(min_x, min_y))
	_spawn_path.curve.add_point(Vector2(max_x, min_y))
	_spawn_path.curve.add_point(Vector2(max_x, max_y))
	_spawn_path.curve.add_point(Vector2(min_x, max_y))
	_spawn_path.curve.add_point(Vector2(min_x, min_y))
			
# Called when the node enters the scene tree for the first time.
func _ready():
	# camera.current = true
	# camera.position = (map_size * 32) / 2
	_draw_map()
	_player.position = (map_size * 32) / 2 # move player to center of map
	$EnemySpawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# print(get_children())
	pass


func _on_EnemySpawnTimer_timeout():
	spawn_triangle()
