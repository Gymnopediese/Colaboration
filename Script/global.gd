# **************************************************************************** #
#                                                                              #
#  Est plus un set d'informations qui vont etre accessible					   #
#  Dans tout le projet                                                         #
#                                                                              #
# **************************************************************************** #

extends Node

# blocs pour un round (longueur)
const y_blocks_per_round = 15;
const y_blocks_per_checkpoint = 11;

# largeur
const x_blocks = 15;
const x_blocks_border = 3;

#Road
const road_size = 4;

#Camera
var camera_start = false

###### to be defined by the settings #######

var number_of_rounds = 3		# Le nombre de checkpoint / de round
var action_speed = 5			# temps d'une action en secondes : va determiner la vitesse du jeu
var number_of_players = 2



#### UTILS.gd 
func global_pos_to_map_pos(vect) -> Vector2:
	return Vector2(vect.x / 16, vect.y / 16)
