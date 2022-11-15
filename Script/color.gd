extends Node2D

class_name MoveColor

func _draw():
	var rect = Rect2(Vector2(0, 0), Vector2( 50, 50))
	var col = Color(1, 0, 0)
	draw_rect(rect, col)
	
func _init():
	print("MoveColor constructed")
