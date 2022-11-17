extends Node


func freeSceneList(list):
	for i in range(len(list)):
		list[i].queue_free()
	list.clear()

func newScene(path, parent, position = Vector2(0, 0), rotation = 0, color = 0xffffff):
	var new_scene = load(path).instance()
	parent.add_child(new_scene)
	new_scene.position = position
	new_scene.modulate = color
	return new_scene

func cloneScene(scene, parent, position = Vector2(0, 0), rotation = 0, color = 0xffffff):
	var new_scene = scene.instance()
	parent.add_child(new_scene)
	new_scene.position = position
	new_scene.modulate = color
	return new_scene

