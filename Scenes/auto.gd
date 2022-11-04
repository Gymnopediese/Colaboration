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
const tile_x = 32
const tile_y = 16

func _ready():
	populate_chunk1(5)
	populate_border()
	populate_basic_middle()

# le bridge
func populate_chunk1(y_start: int):
	add_child(chunk1)
	var start = Vector2(-32, 15)
	chunk1.set_position(start + Vector2(y_start * tile_x, y_start * -tile_y))

# ajoute les bords
func populate_border():
	for x in range(g.x_blocks_border):
		for y in range(0, (-g.y_blocks_per_round -g.y_blocks_per_checkpoint) * g.number_of_rounds, -1):
			set_cell(x, y, t_id.water)
			set_cell(x + g.x_blocks_border + g.x_blocks, y, t_id.water)

# ajoute une premiere couche d'herbe qui va etre ecrasee
# par le random apres coup
func populate_basic_middle():
	for x in range(g.x_blocks):
		for y in range(0, (-g.y_blocks_per_round -g.y_blocks_per_checkpoint) * g.number_of_rounds, -1):
			set_cell(x + g.x_blocks_border, y, t_id.grass)
