extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const Item = preload("res://Script/Item.gd")

class Tile:
	var colision: bool
	#todo Item obj
	var item: Item

# TODO en autoload ? 
# en vrai vu que ca reste dans ce node ca fait du sens
onready var map = get_parent().get("map")

func populate_map():
	for x in range (15):
		map.append([])
		for y in range (100):
			map[x].append(Tile.new())
			map[x][y].colision = false;
			map[x][y].item = null;

func _ready():
	print("mapinit")
	populate_map()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
