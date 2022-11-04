extends TileMap

enum t_id {		# TODO : dans global ??
	grass,
	dirt,
	pav1,
	pav2,
	stone2,
	stone,
	slab,
	stair,
	water,
	wheat,
}

onready var g = get_node("/root/Global")
var chunk1 = load("res://Map/Pont.tscn").instance()
var c1: Node

func _ready():
	populate_border()
	populate_basic_middle()
	populate_border()

# le bridge
func populate_chunk1(y_start: int):
	c1 = add_child(chunk1)


	

# ajoute les bords
func populate_border():
	for x in range(g.x_blocks_border):
		for y in range(0, -g.y_blocks_per_round, -1):
			set_cell(x, y, t_id.water)
			set_cell(x + g.x_blocks_border + g.x_blocks, y, t_id.water)

# ajoute une premiere couche d'herbe qui va etre ecrasee
# par le random apres coup
func populate_basic_middle():
	for x in range(g.x_blocks):
		for y in range(0, -g.y_blocks_per_round, -1):
			set_cell(x + g.x_blocks_border, y, t_id.grass)
