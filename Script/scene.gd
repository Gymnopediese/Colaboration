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
onready var player = load("res://Objects/player.tscn").instance()

var items = []
var map = [[]]

func _ready():
	#populate_items()
	#for x in range (14):
	#	map.append([])
	#	for y in range (100):
	#		map[x].append(0)
	items.push_back(Item.new(0, 0, "res://Objects/text.tscn", self))
	populate_player()
	# TODO test signal
	emit_signal("action")

# TODO dynamic
func populate_player():
	add_child(player)
	player.set_position(Vector2(500, -50))
	player.name = "Player"

# TODO mettre dans utils.gd
func global_pos_to_map_pos(vect):
	return Vector2(vect.x / 32, vect.y / 16)
