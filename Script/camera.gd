extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"



var SPEED1 = 100
var SPEED2 = 0.2
var ZOOMING = 20
# Called when the node enters the scene tree for the first time.

func camtrack(num):
	return (num) * 0.5 - 160


func set_pos_mode_1(delta, name):
	var xtemp = Players.get_child(0).get(name).y * 32
	var x = xtemp + 500
	var y = -camtrack(xtemp)
	position = position.move_toward(Vector2(x, y), SPEED1 * delta)
	
func set_pos_mode_2(delta):
	var map_pos = Players.get_child(0).get("map_pos")
	var map_pos_current = Players.get_child(0).get("map_pos_current")
	var diff = 0
	diff = abs(- map_pos.y + map_pos_current.y) / ZOOMING + 1
	zoom = zoom.move_toward(Vector2(diff, diff), SPEED2 * delta)
	set_pos_mode_1(delta, "map_pos_current")


func _process(delta):
	if Global.camera_start:
		set_pos_mode_2(delta)
#set_pos_mode_2(delta)



#320, 160
