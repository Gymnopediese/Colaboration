extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const Item = preload("res://Script/Item.gd")

class Tile:
	var colision: bool
	#todo Item obj
	var item: Item

func populate_map():
	for x in range (15):
		Scene.map.append([])
		for y in range (100):
			Scene.map[x].append(Tile.new())
			Scene.map[x][y].colision = false
			Scene.map[x][y].item = null

func _ready():
	populate_map()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
