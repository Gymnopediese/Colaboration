# **************************************************************************** 
#                                                                              
#  Player logic -> les fleches, la selection des actions, ...
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
# stack de la valeur des movement (movement simple = 1 mais mouvement + action > 1)
var mvalue = []
# stack des objets fleches
var paths = []
# nombre de mouvement
var mcount = 10
# nombre de mouvement utilisé
var ccount = 0
# bool pour lancer l'animation
var animation = false
# vitesse de l'animation
var SPEED = 1000


#detruit tout les objets dune list et clear la list
func clearObjList(list):
	for i in range(len(list)):
		list[i].queue_free()
	list.clear()
		

#spawn une nouvel flech et lajoute a la list de fleches
func newarrow(pos, rot):
	# var projectile = load("res://player_test/scenes/arrow.tscn")
	var arrow = projectile.instance()
	arrow.global_position = pos
	arrow.rotation = rot
	get_parent().add_child(arrow)
	paths.push_front(arrow)


#clear tout les moves, detruit toutes les fleches
func clear_moves(vect):
	moves.clear()
	mvalue.clear()
	clearObjList(paths)
	get_node("fpos").global_position = vect
	ccount = 0
	moves.append(position)

#push front un move donc creer une flech etc
func push_move(vect, angle):
	moves.push_front(vect)
	mvalue.push_front(1)
	get_node("fpos").global_position = vect
	newarrow(vect, angle)
	ccount += 1
	

#pop un move donc detruit les fleches et recalcule le conteur
func pop_move(vect):
	moves.pop_front()
	paths[0].queue_free()
	paths.pop_front()
	get_node("fpos").global_position = vect
	ccount -= mvalue[0]
	mvalue.pop_front()
	
func action(vect, angle):
	# moves[0] = derniere position enregistré
	# set vect to position relative au dernier mouvement
	vect = moves[0] + vect
	if (vect == position):
		clear_moves(vect)
	elif len(moves) > 1 and moves[1] == vect:
		pop_move(vect)
	elif not moves.has(vect) and ccount < mcount:
		push_move(vect, angle)

# lock l'action en la prenant a la map
# TODO: peux etre ameliorer je supose
func lock_action():
	var items_pos = get_parent().get("items_pos")
	var items_val = get_parent().get("items_val")
	if items_pos.has(moves[0]):
		var val = items_val[items_pos.find(moves[0])]
		if mvalue[0] - 1 ==  val:
			mvalue[0] -= val
			ccount -= val
		elif ccount + val <= mcount:
			mvalue[0] += val
			ccount += val
		else:
			print("shutth")


func _input(event):
	if (len(moves) == 0):
		moves.append(position)
	if event is InputEventKey:
		if animation == false:
			if event.pressed and event.scancode == KEY_UP:
				action(Vector2(32, -16), - PI / 4)
			if event.pressed and event.scancode == KEY_DOWN:
				action(Vector2(-32, 16), 3 * PI / 4)
			if event.pressed and event.scancode == KEY_LEFT:
				action(Vector2(-32, -16), - 3 * PI / 4)
			if event.pressed and event.scancode == KEY_RIGHT:
				action(Vector2(32, 16), PI / 4)
			#CHOISIR UNE ACTION
			if event.pressed and event.scancode == KEY_SPACE:
				lock_action()
		#move
		if event.pressed and event.scancode == KEY_ENTER:
			animation = true
			moves.pop_back()

func _process(delta):
	#set le label pour match avec le nombre de moves restant
	#TODO: peu etre appeler moin souvent lol
	get_parent().get_node("Label").text = str(ccount) + " / " + str(mcount)
	#movement de lanimation SPEEP pour gerer la vitesse de deplacement
	#animation = True if enter press
	#TODO: peu etre ameliorer grace au thread ou autres tech godo
	if (animation):
		position = position.move_toward(moves[len(moves) - 1], SPEED * delta)
		if (moves[len(moves) - 1] == position):
			moves.pop_back()
			paths[len(paths) - 1].queue_free()
			paths.pop_back()
		if (len(moves) == 0):
			animation = false
			ccount = 0
		get_node("fpos").global_position = position
