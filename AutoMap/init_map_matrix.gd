extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

class Tile:
	var colision: bool
	#todo Item obj
	var item: int
		

onready var map = get_parent().get("map")

func populate_map():
	for x in range (15):
		map.append([])
		for y in range (100):
			map[x].append(Tile.new())
			map[x][y].colision = false;
			map[x][y].item = 0;

func _ready():
	populate_map()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
