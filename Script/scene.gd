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
onready var player = load("res://Objects/player.tscn").instance()

# TODO: mettre dans un autoload que tous on acces
var map = [[]]

func _ready():
	process_priority = -100
	add_item(Vector2(0, 0), 0) # for test


func add_item(pos: Vector2, item_id: int):
	# TODO addapt le choix d'item avec l'id, avec l'enum en question
	var new: Item = Item.new(pos, "res://Arts/objects/Items/0_key.png")
	map[pos.x][pos.y] = (new)
	add_child(new)

# TODO dynamic
func populate_player():
	add_child(player)
	player.set_position(Vector2(500, -50))
	player.name = "Player"

func global_pos_to_map_pos(vect):
	return Vector2(vect.x / 32 + vect.y / 16, vect.x / 16 + vect.y / 32)
