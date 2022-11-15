# **************************************************************************** 
#                                                                              
#  Set d'informations accessibles
#  Dans tout le projet                                                         
#                                                                              
# **************************************************************************** 

extends Node

# blocs pour un round (longueur)
const y_blocks_per_round = 30;
const y_blocks_per_checkpoint = 30;

# largeur
const x_blocks = 15;
const x_blocks_border = 3;


###### to be defined by the settings #######

var number_of_rounds = 3		# Le nombre de checkpoint / de round
var number_of_players = 2
var action_speed = 5			# temps d'une action en secondes : va determiner la vitesse du jeu


var test = 0
