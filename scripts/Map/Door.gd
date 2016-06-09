
extends "../Entities/Objects/Object.gd"

func _ready():
	map_object = true

func _on_Entity_input_event( camera, event, click_pos, click_normal, shape_idx ):
	if (is_selected and can_selected and !map_object):
		checkAvailableProcess()
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click") && can_selected == true:
		poseWall()

func poseWall():
	print(checkWalls())

func checkWalls():
	updateTilePosition()
	if (tile.walls_types.Up != 0):
		return false
	if (tile.walls_types.Down != 0):
		return false
	if (tile.walls_types.Left != 0):
		return false
	if (tile.walls_types.Right != 0):
		return false
	return true