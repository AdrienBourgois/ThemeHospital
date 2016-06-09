
extends "../Entities/Objects/Object.gd"

var wall
var trans

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
		
		game.feedback.display("TOOLTIP_DOOR_CREATION")

func _input(event):
	if (event.is_action_released("left_click")):
		updateTilePosition()
		checkWalls()

func poseDoor():
	setUpItem()
	game.feedback.display("TOOLTIP_POSEDOOR_POSED")
	set_translation(trans)

func checkWalls():
	trans = get_translation()
	if (tile.walls_types.Up == 1):
		tile.walls_types.Up = 3
		set_rotation(Vector3(0,0,0))
		poseDoor()
		trans.z += 0.5
		return true
	if (tile.walls_types.Down == 1):
		tile.walls_types.Down = 3
		set_rotation(Vector3(0,0,0))
		poseDoor()
		trans.z -= 0.5
		return true
	if (tile.walls_types.Left == 1):
		tile.walls_types.Left = 3
		set_rotation(Vector3(0,deg2rad(90),0))
		trans.x -= 0.5
		poseDoor()
		return true
	if (tile.walls_types.Right == 1):
		tile.walls_types.Right = 3
		set_rotation(Vector3(0,deg2rad(90),0))
		trans.x += 0.5
		poseDoor()
		return true
	game.feedback.display("TOOLTIP_POSEDOOR_ERROR")
	return false