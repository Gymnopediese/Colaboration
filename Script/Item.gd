extends Sprite
class_name Item

var map_pos: Vector2
var pix_pos: Vector2 # Position absolue en pixel (la premiere)


# TODO dans global ?
func map_pos_to_px(vect) -> Vector2:
	# La tilemap a ce decalage, c'est la faute de Quentin (deso)
	# du coup tout est decale a partir de ca
	# quand on aura tout merge je recalerai tout
	var decalage_de_depart = Vector2(-18, 2)
	
	# Pour que l'objet sois au milieu de la tile
	var decalage_mi_tile = Vector2(0, 16)
	
	# Ce petit calcul permet de translate le deplacement du tableau de la map
	# aux vrai pixel, en diagonale
	var x_dec = Vector2(32, 16) * vect.x
	var y_dec = Vector2(32, -16) * vect.y
	print(x_dec, y_dec)
	return x_dec + y_dec + decalage_de_depart + decalage_mi_tile

# TODO position absolue = dans le block en haut a gauche (pk pas en bas a gauche ??) 
func _init(map_pos, sprite_path: String):
	self.map_pos = map_pos
	texture = load(sprite_path)
	position = map_pos_to_px(map_pos)
	#position = Vector2(0, 0)



# TODO -> ira dans chaque endroit qui gere les items (inventaire, scene ,...)
#	self.parent.connect("action", self, "on_action");
#	self.parent.connect("walked", self, "on_walked");

#func on_action():
#	print("actin on")

#func on_walked():
#	print("actin on")
