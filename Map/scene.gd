extends Node2D


onready var g = get_node("/root/Global")
onready var player = load("res://player.tscn").instance()


func _ready():
	populate_player()


func populate_player():
	add_child(player)
	player.set_position(Vector2(500, -50))
	
