extends Node2D

export(PackedScene) var triangle_scene

onready var _player: KinematicBody2D = $Player
onready var _tilemap = $TileMap
onready var _spawn_path = $Path2D
onready var _map_area2d = $MapExtents
onready var _map_collision_size = $MapExtents/CollisionShape2D


signal enemy_death
signal new_game
onready var camera = $Camera2D

var map_x = 24
var map_y = 24
var map_size = Vector2(map_x, map_y) # size in number of cells

func create_triangle():
	var location = $Path2D/PathFollow2D
	location.offset = randi()
	# print(location.offset)

	var spawned_enemy = triangle_scene.instance()
	spawned_enemy.position = location.position
	spawned_enemy.connect("death", self, "_on_Enemy_death")
	add_child(spawned_enemy)

# spawns enemy triangle(s)
func spawn_triangle():
	var count = 0
	var children = get_children()
	var regex = RegEx.new()
	regex.compile("TriangleEnemy")
	for child in children:
		var result = regex.search(child.name)
		if result:
			count += 1
	
	print("Enemies on screen: " + String(count))
	randomize()
	var chance = randi() % 10

	# TODO: Fix spawning near player. (dont spawn near player)
	# print(chance)
	if chance < 8 and count <= 6:
		if chance > 4:
			create_triangle()
			create_triangle()
		else:
			create_triangle()
		$EnemySpawnTimer.stop()
		$SpawnCooldownTimer.start()

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

	_map_collision_size.shape.extents = Vector2(map_x * 16, map_y * 16)
	_map_area2d.position = (map_size * 32) / 2
			
# Called when the node enters the scene tree for the first time.
func _ready():
	camera.current = true
	camera.position = (map_size * 32) / 2
	new_level()
	
func _on_EnemySpawnTimer_timeout():
	spawn_triangle()

func _on_Enemy_death():
	emit_signal("enemy_death")

func new_level():
	emit_signal("new_game")
	_draw_map()
	_player.position = (map_size * 32) / 2
	_player.health = 100
	$EnemySpawnTimer.start()

func clear_level():
	$EnemySpawnTimer.stop()
	$SpawnCooldownTimer.stop()
	var regex = RegEx.new()
	regex.compile("TriangleEnemy")
	for n in get_children():
		var result = regex.search(n.name)
		if result:
			n.queue_free()

func _on_SpawnCooldownTimer_timeout():
	$EnemySpawnTimer.start()
