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
onready var checkpoint = load("res://Map/Checkpoints/Checkpoint.tscn").instance()
var chunk1 = load("res://Map/Pont.tscn").instance()
const tile_x = 32
const tile_y = 16

var rng = RandomNumberGenerator.new();

#TODO: CASSE TOI DE LAAAAA (mais jai pas le choix pour le moment c la vie pardon)
var map

func _ready():
	print("col")
	map = get_parent().get("map")
	rng.seed = OS.get_time().second
	#rng.seed = 42
	var round_size : int = -g.y_blocks_per_round - g.y_blocks_per_checkpoint
	var distance : int
	#populate_chunk1(5)
	for i in range(g.number_of_rounds):
		populate_border(distance)
		populate_basic_middle(distance)
		populate_road(distance)
		populate_dirt(distance)
		populate_wheat(distance)
		add_check_point(-g.y_blocks_per_round + distance, checkpoint, checkpoint.get_node("Layer2"))
		distance += round_size

# set cell + set colition
func set_sell_and_colid(x, y, tile, obj):
	obj.set_cell(x, y, tile)
	map[x - 2][-y - 1].colision = true;

# le bridge
func populate_chunk1(y_start: int):
	add_child(chunk1)
	var start = Vector2(-32, 15)
	chunk1.set_position(start + Vector2(y_start * tile_x, y_start * -tile_y))

# ajoute les bords
func populate_border(start : int):
	for x in range(g.x_blocks_border):
		for y in range(start, -g.y_blocks_per_round + start, -1):
			set_cell(x, y, t_id.water)
			set_cell(x + g.x_blocks_border + g.x_blocks, y, t_id.water)
			
# ajoute une premiere couche d'herbe qui va etre ecrasee
# par le random apres coup
func populate_basic_middle(start : int):
	for x in range(g.x_blocks):
		for y in range(start, -g.y_blocks_per_round + start, -1):
			set_cell(x + g.x_blocks_border, y, t_id.grass)

func populate_road(start : int):
	var shift : int
	for y in range(start, -g.y_blocks_per_round + start, -1):
		shift = abs(y % 6)
		if (shift > 2):
			shift = 1;
		else:
			shift = 0
		for x in range(g.x_blocks / 2 - g.road_size / 2, g.x_blocks / 2 + 1, 1):
			if get_cell(x - 1 + g.x_blocks_border + shift, y) == t_id.stone || rng.randi_range(0, 10) != 0:
				set_cell(x + g.x_blocks_border + shift, y, t_id.stone)
		for x in range(g.x_blocks / 2 + g.road_size / 2, g.x_blocks / 2 - 1, -1):
			if get_cell(x + 1 + g.x_blocks_border + shift, y) == t_id.stone || rng.randi_range(0, 10) != 0:
				set_cell(x + g.x_blocks_border + shift, y, t_id.stone)

func populate_dirt(start : int):
	for x in range(g.x_blocks):
		for y in range(start, -g.y_blocks_per_round + start, -1):
			if get_cell(x + g.x_blocks_border, y + 1) == t_id.dirt && rng.randi_range(0, 4) != 0:
				set_cell(x + g.x_blocks_border, y, t_id.dirt)
			if get_cell(x + g.x_blocks_border, y) == t_id.grass:
				if (rng.randi_range(0, 20) == 0):
					set_cell(x + g.x_blocks_border, y, t_id.dirt)
			if (get_cell(x - 1 + g.x_blocks_border, y) == t_id.dirt):
				if (get_cell(x + g.x_blocks_border, y) == t_id.dirt && rng.randi_range(0, 2) == 0):
					set_cell(x + g.x_blocks_border, y, t_id.dirt)
					
func populate_wheat(start : int):
	for x in range(g.x_blocks):
		for y in range(start, -g.y_blocks_per_round + start, -1):
			if (get_cell(x + g.x_blocks_border, y) == t_id.dirt):
				set_sell_and_colid(x + g.x_blocks_border - 1, y - 1, t_id.wheat, $Layer2)
				
func add_check_point(y_start : int, Layer1 : TileMap, Layer2 : TileMap):
	for x in range(g.x_blocks + g.x_blocks_border * 2):
		for y in range (0, -g.y_blocks_per_checkpoint, -1):
			set_cell(x, y + y_start, Layer1.get_cell(x, y))
			$Layer2.set_cell(x, y + y_start, Layer2.get_cell(x, y))
