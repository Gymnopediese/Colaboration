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
var player_moves = preload("res://Script/player/player_mouvement.gd").new()

#onready var t_map : Game_Area = get_parent().get_node("TileMap")
onready var parent = get_parent()

#Puppet variables

puppet var puppet_position = Vector2(0, 0) setget puppet_position_set
puppet var puppet_time_out = Vector2(0, 0) setget puppet_time_out_set
#send a signal to update the map
puppet var puppet_msignals = [] setget puppet_msignals_set
#set the others tiles
puppet var puppet_thertile = [] setget puppet_thertile_set
#detruit tout les objets dune list et clear la list
		

# node 2d pour mettre les couleurs la ou on va passer
onready var tile = load("res://Objects/tile_path.tscn")

# text pour les deplacements restants du joueur
onready var move_text = load("res://Objects/text.tscn").instance()

#spawn une nouvel flech et lajoute a la list de fleches

# lock l'draw_move en la prenant a la map

# TODO: peux etre ameliorer je supose


func _input(event):
	
	if event is InputEventKey and is_network_master():
		if (len(player_moves.moves) == 0):
			player_moves.moves.append(position)
		if player_moves.is_moving == false:
			if event.pressed and event.scancode == KEY_UP:
				player_moves.draw_move(Vector2(32, -16), Vector2(0, 1))
			if event.pressed and event.scancode == KEY_DOWN:
				player_moves.draw_move(Vector2(-32, 16), Vector2(0, -1))
			if event.pressed and event.scancode == KEY_LEFT:
				player_moves.draw_move(Vector2(-32, -16), Vector2(-1, 0))
			if event.pressed and event.scancode == KEY_RIGHT:
				player_moves.draw_move(Vector2(32, 16), Vector2(1, 0))
			if event.pressed and event.scancode == KEY_SPACE: # Agir sur la tile
				player_moves.lock_draw_move()
		#move # TODO recevoir un signal (toutes les x secondes) pour move
		if event.pressed and event.scancode == KEY_ENTER:
			rset("puppet_msignals", [player_moves.map_pos.x, player_moves.map_pos.y, false])
			player_moves.is_moving = true
			player_moves.moves.pop_back()
			player_moves.map_pos_current = player_moves.map_pos

func _ready():
	player_moves.player = self
	# ajoute le text qui indique le nombre de coup restant au joueur
	add_child(move_text)
	move_text.rect_position = Vector2(0, 0)

func _process(delta):
	# set le nombre de coup au text
	
	#if OS.get_time().second % 10 == 0 and not is_moving:
	#	is_moving = true
	#	moves.pop_back()
	#	map_pos_current = map_pos
	move_text.text = str(player_moves.ccount) + " / " + str(player_moves.mcount)
	player_moves.player_move(delta)

	
#64, 64 = map[0][0]


			
var timeoutcoutn = 0
var timer = 10
func _on_Network_tick_rate_timeout():
	if (is_network_master()):
		rset("puppet_position", global_position)
	"""
	if get_tree().is_network_server():
		timeoutcoutn += 1
		if timeoutcoutn > 20 * timer:
			print("mmmm")
			timeoutcoutn = 0
			rset("puppet_time_out", 1)
			player_moves.is_moving = true
			player_moves.moves.pop_back()
			player_moves.map_pos_current = player_moves.map_pos
	"""

#bouge les autre
#TODO enlever ca
func puppet_position_set(new_value):
	puppet_position = new_value
	$Tween.interpolate_property(self, "global_position", global_position, puppet_position, 0.1)
	$Tween.start()

#creer les tiles des autres, a ameliorö surmeent
func puppet_thertile_set(mode):
	if typeof(mode) == TYPE_INT:
		if mode == -1:
			puppet_thertile[mode].queue_free()
			puppet_thertile.pop_back()
		elif mode == 0:
			puppet_thertile[mode].queue_free()
			puppet_thertile.pop_front()
		else:
			player_moves.clearObjList(puppet_thertile)
	else:
		puppet_thertile.push_front(SceneUtils.cloneScene(tile, get_parent(), mode, 0, 0xffff00ff))

#
func puppet_time_out_set(voidy):
	#player_moves.is_moving = true
	#player_moves.moves.pop_back()
	#player_moves.map_pos_current = player_moves.map_pos
	pass
	
func puppet_msignals_set(signals):
	Scene.map[signals[0]][signals[1]].colision = signals[2]
