# **************************************************************************** 
#                                                                              
#  Player logic -> les fleches, la selection des draw_moves, ...
#  
#                                                                              
# **************************************************************************** 

extends KinematicBody2D

"""
NOTE: je dit stack mais enft c des list que jutilise comme stack
"""
# TODO: rename les variable lol
# TODO: definir les types des variable si possible pour une meuilleur lisibilité
# stack des movements
var moves = []
# stack de la valeur des movement (movement simple = 1 mais mouvement + draw_move > 1)
var mvalue = []
# stack des objets fleches
var paths = []
# nombre de mouvement
var mcount = 10
# nombre de mouvement utilisé
var ccount = 0
# bool pour lancer l'is_moving
var is_moving = false
# vitesse de l'is_moving
const SPEED = 1000

onready var parent = get_parent()


#detruit tout les objets dune list et clear la list
func clearObjList(list):
	for i in range(len(list)):
		list[i].queue_free()
	list.clear()
		

# node 2d pour mettre les couleurs la ou on va passer
onready var color_node = load("res://color.tscn")

# text pour les deplacements restants du joueur
onready var move_text = load("res://Objects/text.tscn").instance()

#spawn une nouvel flech et lajoute a la list de fleches
func newarrow(pos):
	var new_color_node = color_node.instance()
	parent.add_child(new_color_node)
	new_color_node.position = pos
	paths.push_front(new_color_node)


#clear tout les moves, detruit toutes les fleches
func clear_moves(vect):
	moves.clear()
	mvalue.clear()
	clearObjList(paths)
	# get_node("fpos").global_position = vect
	ccount = 0
	moves.append(position)

#push front un move donc creer une flech etc
func push_move(vect):
	moves.push_front(vect)
	mvalue.push_front(1)
	# get_node("fpos").global_position = vect
	newarrow(vect)
	ccount += 1
	

#pop un move donc detruit les fleches et recalcule le conteur
func pop_move(vect):
	moves.pop_front()
	paths[0].queue_free()
	paths.pop_front()
	# get_node("fpos").global_position = vect
	ccount -= mvalue[0]
	mvalue.pop_front()
	
func draw_move(vect):
	# moves[0] = derniere position enregistré
	# set vect to position relative au dernier mouvement
	vect = moves[0] + vect
	if (vect == position):
		clear_moves(vect)
	elif len(moves) > 1 and moves[1] == vect:
		pop_move(vect)
	elif not moves.has(vect) and ccount < mcount:
		push_move(vect)

# lock l'draw_move en la prenant a la map
# TODO: peux etre ameliorer je supose
func lock_draw_move():
	var items = parent.get("items")
	for item in items:
		if item.pos == moves[0]:
			if mvalue[0] - 1 ==  item.val:
				mvalue[0] -= item.val
				ccount -= item.val
			elif ccount + item.val <= mcount:
				mvalue[0] += item.val
				ccount += item.val
			else:
				# TODO animation TG (text qui clignote en rouge ?)
				print("shutth")

func _input(event):
	if (len(moves) == 0):
		moves.append(position)
	if event is InputEventKey:
		if is_moving == false:
			if event.pressed and event.scancode == KEY_UP:
				draw_move(Vector2(32, -16))
			if event.pressed and event.scancode == KEY_DOWN:
				draw_move(Vector2(-32, 16))
			if event.pressed and event.scancode == KEY_LEFT:
				draw_move(Vector2(-32, -16))
			if event.pressed and event.scancode == KEY_RIGHT:
				draw_move(Vector2(32, 16))
			if event.pressed and event.scancode == KEY_SPACE: # Agir sur la tile
				lock_draw_move()
		#move # TODO recevoir un signal (toutes les x secondes) pour move
		if event.pressed and event.scancode == KEY_ENTER:
			print(len(moves))
			is_moving = true
			moves.pop_back()

func _ready():
	# ajoute le text qui indique le nombre de coup restant au joueur
	add_child(move_text)
	move_text.rect_position = Vector2(0, 0)

func _process(delta):
	player_move(delta)
	# set le nombre de coup au text
	move_text.text = str(ccount) + " / " + str(mcount)

func player_move(delta):
	# animation du joueur si is_moving == TRUE
	# SPEEP pour gerer la vitesse de deplacement
	if (is_moving ):
		# TODO ca buug
		position = position.move_toward(moves[len(moves) - 1], SPEED * delta)
		if (moves[len(moves) - 1] == position):
			moves.pop_back()
			paths[len(paths) - 1].queue_free()
			paths.pop_back()
		if (len(moves) == 0):
			is_moving = false
			ccount = 0
