extends Node2D



class_name Item

var x: int
var y: int
var prefab_path: String
var prefab_instance
var parent

var action_point: int # devrait rester 1 pour l'instant

func populate():
	self.prefab_instance = load(prefab_path).instance()
	self.parent.add_child(self.prefab_instance)
	self.prefab_instance.rect_position = Vector2(self.x, self.y)
	self.prefab_instance.text = str(self.action_point)

func _init(x: int, y: int, prefab_path: String, parent):
	self.x = x
	self.y = y
	self.action_point = action_point
	self.prefab_path = prefab_path
	self.parent = parent
	self.populate()
	self.parent.connect("action", self, "on_action");
	self.parent.connect("walked", self, "on_walked");

func on_action():
	print("actin on")

func on_walked():
	print("actin on")
