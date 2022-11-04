tool
extends TileMap

var offset = Vector2(-64, -385)

func _ready():
	for tile in tile_set.get_tiles_ids().size():
		print(tile, offset, "yaa")
		tile_set.tile_set_texture_offset(tile, offset)
