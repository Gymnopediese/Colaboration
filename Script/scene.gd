# **************************************************************************** 
#                                                                              
#  "Start" la map
#   Add le player
#	Add les objects
#                                                                              
# **************************************************************************** 

extends Node2D

onready var g = get_node("/root/Global")
onready var player = load("res://Objects/player.tscn").instance()

func _ready():
	populate_player()
	populate_items()

func populate_player():
	add_child(player)
	player.set_position(Vector2(500, -50))


# TODO en faire une classe generale
class Item:
	var pos: Vector2
	var val: int
	
# TODO en faire une method !
func from(pos, val):
	var res = Item.new()
	res.pos = pos
	res.val = val
	return res
# tout les items
func populate_items():
	var items = [
		from(Vector2(0, 0), 1),
		from(Vector2(10, 10), 2),
		from(Vector2(100, 100), 3)
	]
	for item in items:
		populate_item("res://text.tscn", item)
		print(item.pos)
# Va populate un item (juste un nombre)
func populate_item(path, item, rot = 0, child = true):
	var projectile = load(path).instance()
	add_child(projectile)
	projectile.rect_position = item.pos
	projectile.text = str(item.val)

