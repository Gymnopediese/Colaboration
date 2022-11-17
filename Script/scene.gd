# **************************************************************************** 
#                                                                              
#  "Start" la map
#   Add le player
#	Add les objects
#                                                                              
# **************************************************************************** 

extends Node2D

# signal action
# signal walked

onready var g = get_node("/root/Global")
onready var player = load("res://Objects/player.tscn")

# TODO: mettre dans un autoload que tous on acces
var map = [[]]

func _ready():
	process_priority = -100
	add_item(Vector2(5, 4), 0) # for test

func add_item(pos: Vector2, item_id: int):
	# TODO addapt le choix d'item avec l'id, avec l'enum en question
	var new: Item = Item.new(pos, "res://Arts/objects/Items/0_key.png")
	# map[pos.x][pos.y].item = new # TODO je comprend pas cette map
	add_child(new)

var colors = [0xffffffff, 0x2600ffff, 0x00ff10ff, 0xfff008ff]
func populate_player(id : int, color : int):
	var player_instance = player.instance()
	player_instance.set_position(Vector2(64, 64))
	player_instance.name = str(id)
	player_instance.set_network_master(id)
	player_instance.modulate = colors[color]
	Players.add_child(player_instance)

func global_pos_to_map_pos(vect):
	return Vector2(vect.x / 32 + vect.y / 16, vect.x / 16 + vect.y / 32)
