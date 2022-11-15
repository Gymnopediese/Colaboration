extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var players = []

# Called when the node enters the scene tree for the first time.
func _ready():
	players.push_back(get_parent().get_node("Player"))

func camtrack(num):
	return (num) * 0.5 - 160
func _process(delta):
	position.x = players[0].position.x
	position.y = -camtrack(players[0].position.x)



#320, 160
