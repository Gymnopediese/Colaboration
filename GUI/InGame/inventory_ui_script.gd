extends CanvasLayer

# TODO : les infos live des joueurs doivent etre dispo dans Global !
onready var g = $"/root/Global"
const item_folder_prefab = preload("res://GUI/InGame/item_folder.tscn") # TODO -> changer d'endroit !
onready var box = $Rect/Box
# TODO : dans global 
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
	for i in range(0, item_folder_quantity):
		item_folder_objects.push_back(ItemFolder.new(box))

# Un class pour chaque case (itemfolder) de l'inventaire
class ItemFolder:
	var item_id: int
	var item_quantity: int
	var folder_object: Panel
	var parent: Object
	var number_panel: Panel
	var number_text: Label
	
	func _init(parent: Object):
		self.item_id = -1
		self.item_quantity = 0
		self.folder_object = item_folder_prefab.instance()
		self.number_panel = self.folder_object.get_child(0)
		self.number_text = self.number_panel.get_child(0)
		self.number_panel.visible = false # rend le numero invisible (s'il n'y a qu'un seul objet
		self.parent = parent
		self.parent.add_child(self.folder_object)

	# ajoute un item s'il y'en a deja un du meme type dans l'inventaire
	func add_same_item(new_quantity: int):
		self.number_panel.visible = true
		self.number_text.text = str(new_quantity)

# TODO class Player ! enum type ?
# L'idee serait d'utiliser un signal envoyer partout des qu'un objets est ramasse
# Comme ca la map peu aussi le faire disparaitre, et chaque joueur recois le truc
func player_took_item(player: Object, item_type_id: int):
	#if player != "nous tu vois":
	#	return
	#index:int = find_item_index_in_list(item_type_id)
	#if index == -1:
	#	add_new()
	#else:
	#	add_same_item(item_folder_objects[index], calcul())
	# TODO finir ca quoi
	pass

func find_item_index_in_list(item_type_id: int):
	for i in len(item_folder_objects):
		if (item_folder_objects[i].id == item_type_id):
			return i
	return -1
	

