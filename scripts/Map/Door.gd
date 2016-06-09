
extends "../Entities/Objects/Object.gd"

var wall

func _ready():
	map_object = true

func _process(delta):
	var cube_scale = cube.get_scale()
	if can_selected == true:
		var cube_scale = cube.get_scale()
		mouse_pos_3d = map.center_tile_on_cursor
		
		var translate = map.tile_on_cursor
		set_translation(Vector3(translate.x, cube_scale.y, translate.y))
		set_process_input(true)

func _input(event):
	if (event.is_action_released("left_click")):
		updateTilePosition()
		checkWalls()

func poseDoor():
	deleteFromArray()
	nextObject()

func checkWalls():
	if (tile.walls_types.Up == 1):
		tile.walls_types.Up = 3
		poseDoor()
		return true
	if (tile.walls_types.Down == 1):
		tile.walls_types.Down = 3
		poseDoor()
		return true
	if (tile.walls_types.Left == 1):
		tile.walls_types.Left = 3
		poseDoor()
		return true
	if (tile.walls_types.Right == 1):
		tile.walls_types.Right = 3
		poseDoor()
		return true
	game.feedback.display("TOOLTIP_POSEDOOR_ERROR")
	return false