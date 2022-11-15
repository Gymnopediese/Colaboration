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
var rng = RandomNumberGenerator.new();

func _ready():
	rng.seed = 42
	populate_chunk1(5)
	populate_border()
	populate_basic_middle()
	populate_road()
	populate_dirt()
	populate_wheat()

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
			
func populate_road():
	var shift : int
	for y in range(0, -g.y_blocks_per_round * g.number_of_rounds, -1):
		shift = abs(y % 6)
		if (shift > 2):
			shift = 1;
		else:
			shift = 0
		for x in range(g.x_blocks / 2 - g.road_size / 2, g.x_blocks / 2 + 1, 1):
			if get_cell(x - 1 + g.x_blocks_border + shift, y) == t_id.stone || rng.randi_range(0, 10) != 0:
				set_cell(x + g.x_blocks_border + shift, y, t_id.stone)
		for x in range(g.x_blocks / 2 + (g.road_size + 1) / 2, g.x_blocks / 2 - 1, -1):
			if get_cell(x + 1 + g.x_blocks_border + shift, y) == t_id.stone || rng.randi_range(0, 10) != 0:
				set_cell(x + g.x_blocks_border + shift, y, t_id.stone)
func populate_dirt():
	for x in range(g.x_blocks):
		for y in range(0, (-g.y_blocks_per_round -g.y_blocks_per_checkpoint) * g.number_of_rounds, -1):
			if get_cell(x + g.x_blocks_border, y + 1) == t_id.dirt && rng.randi_range(0, 4) != 0:
				set_cell(x + g.x_blocks_border, y, t_id.dirt)
			if get_cell(x + g.x_blocks_border, y) == t_id.grass:
				if (rng.randi_range(0, 20) == 0):
					set_cell(x + g.x_blocks_border, y, t_id.dirt)
			if (get_cell(x - 1 + g.x_blocks_border, y) == t_id.dirt):
				if (get_cell(x + g.x_blocks_border, y) == t_id.dirt && rng.randi_range(0, 2) == 0):
					set_cell(x + g.x_blocks_border, y, t_id.dirt)
func populate_wheat():
	for x in range(g.x_blocks):
		for y in range(0, (-g.y_blocks_per_round -g.y_blocks_per_checkpoint) * g.number_of_rounds, -1):
			if (get_cell(x + g.x_blocks_border, y) == t_id.dirt):
				$Layer2.set_cell(x + g.x_blocks_border - 1, y - 1, t_id.wheat)












