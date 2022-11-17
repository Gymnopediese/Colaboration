extends Node

var map_pos = Vector2(0, 0)

var map_pos_current = Vector2(0, 0)
# stack des movements
var moves = [Vector2(64, 64)]
# stack de la valeur des movement (movement simple = 1 mais mouvement + draw_move > 1)
var mvalue = []
# stack des objets fleches
var paths = []
# nombre de mouvement
var mcount = 100
# nombre de mouvement utilisé
var ccount = 0
# bool pour lancer l'is_moving
var is_moving = false
# vitesse de l'is_moving
const SPEED = 100
var player
#clear tout les moves, detruit toutes les fleches
func clear_moves(vect):
	moves.clear()
	mvalue.clear()
	SceneUtils.freeSceneList(paths)
	# get_node("fpos").global_position = vect
	ccount = 0
	moves.append(player.position)
	rset("puppet_thertile", 3)
#push front un move donc creer une flech etc
func push_move(vect):
	moves.push_front(vect)
	mvalue.push_front(1)
	# get_node("fpos").global_position = vect
	paths.push_front(SceneUtils.cloneScene(player.tile, player.get_parent(),vect))
	ccount += 1
	rset("puppet_thertile", vect)
#pop un move donc detruit les fleches et recalcule le conteur
func pop_move(vect):
	rset("puppet_thertile", 0)
	moves.pop_front()
	paths[0].queue_free()
	paths.pop_front()
	# get_node("fpos").global_position = vect
	ccount -= mvalue[0]
	mvalue.pop_front()
func player_move(delta):
	# animation du joueur si is_moving == TRUE
	# SPEEP pour gerer la vitesse de deplacement
	if is_moving:
		# TODO ca buug
		if len(moves) != 0:
			player.position = player.position.move_toward(moves[len(moves) - 1], SPEED * delta)
			if (moves[len(moves) - 1] == player.position):
				moves.pop_back()
				if len(paths) != 0:
					paths[len(paths) - 1].queue_free()
					paths.pop_back()
					rset("puppet_thertile", -1)
		else:
			rset("puppet_msignals", [map_pos.x, map_pos.y, true])
			moves.append(player.global_position)
			is_moving = false
			ccount = 0
func draw_move(vect, vect_map):
	# moves[0] = derniere position enregistré
	# set vect to position relative au dernier mouvement
	vect = moves[0] + vect
	var temp = map_pos + vect_map
	if temp.x < 0 or temp.y < 0 or temp.x > 14 or temp.y > 100 or Scene.map[temp.x][temp.y].colision:
		return
	#if !t_map.can_move(temp):
	#	return
	map_pos += vect_map
	if (vect == player.position):
		clear_moves(vect)
	elif len(moves) > 1 and moves[1] == vect:
		pop_move(vect)
	elif not moves.has(vect) and ccount < mcount:
		push_move(vect)
	else:
		map_pos -= vect_map

func lock_draw_move():
	var items = player.parent.get("items")
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

