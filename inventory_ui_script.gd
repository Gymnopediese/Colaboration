extends CanvasLayer

# TODO : les infos live des joueurs doivent etre dispo dans Global !
onready var g = $"/root/Global"
onready var item_folder_prefab = load("res://inventory_ui.tscn") # TODO -> changer d'endroit !

# TODO : dans global ?
const item_folder_quantity: int = 6

var item_folder_objects = []


# Avec un ID par (type d') objet, ca me permet ici de prendre directement le sprite
# Et pas de lier autrement.
# Comme ca je gere la taille du sprite de l'item direct dans l'inventaire
enum ItemTypeId {
	POT_DE_FLEUR,
	EXAMPLE2
}

func _ready():
	instanciate_item_folders()


func instanciate_item_folders():
	for i in range(0, item_folder_quantity):
		item_folder_objects.push_back(instanciate_item_folder())
		
func instanciate_item_folder():
	var object = item_folder_prefab.instance()
	# TODO
	return object

# TODO utiliser des signaux pour moins de render ??
func _process(delta):
	# TODO if le state du jeu n'est pas "pause" ou autre ?
	# pdate_timer(g.decont, delta) 
	# TODO if le score gold a change:
	# update_gold_score(g.player.gold_score)
	# TODO if les move points on change:
	# update_gold_score(g.player.gold_score)

	#update_gold_score(gold)
	pass
"""

func update_gold_score(new_score: int):
	print (new_score)
	gold_count_text.text = str(new_score)
	# TODO animation ? # bourse / tas d'or qui monte ?


func update_move_points(new_points: int,  new_max: int):
	moving_points_text.text = str(new_points)
	moving_points_max_text.text = str(new_max)
	# TODO animation ?
	# scale le text s'il passe ne dizaine (s'il ne prend plus la meme place)

func update_timer(new_decount: int, _delta: float):
	# TODO int ou float ?? (Quentin prefere int)
	timer_counter_text.text = str(new_decount)
"""
