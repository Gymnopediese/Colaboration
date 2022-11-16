# **************************************************************************** 
#                                                                              
#  "Start" la map
#   Add le player
#	Add les objects
#                                                                              
# **************************************************************************** 

extends Node2D

signal action
signal walked

onready var g = get_node("/root/Global")
onready var player = load("res://Objects/player.tscn")

var map = [[]]

func _ready():
	process_priority = -100
	#populate_player()
	populate_items()
	items.push_back(Item.new(0, 0, "res://Objects/text.tscn", self))
	# TODO test signal
	emit_signal("action")

# TODO dynamic
func populate_player(id : int):
	var player_instance = player.instance()
	player_instance.set_position(Vector2(64, 64))
	player_instance.name = str(id)
	player_instance.set_network_master(id)
	Players.add_child(player_instance)

# TODO en faire une classe generale
#class Item:
#	var pos: Vector2
#	var val: int
	
# TODO en faire une method !
var items = []
"""
func from(pos, val):
	var res = Item.new()
	res.pos = pos
	res.val = val
	return res


export onready var items = [
		from(Vector2(0, 0), 1),
		from(Vector2(10, 10), 2),
		from(Vector2(100, 100), 3)
	]
"""


# tout les items
func populate_items():
	for item in items:
		populate_item("res://Objects/text.tscn", item)
		print(item.pos)

func global_pos_to_map_pos(vect):
	return Vector2(vect.x / 32 + vect.y / 16, vect.x / 16 + vect.y / 32)

# Va populate un item (juste un nombre)
func populate_item(path, item, rot = 0, child = true):
	var projectile = load(path).instance()
	add_child(projectile)
	projectile.rect_position = item.pos
	projectile.text = str(item.val)

