extends Spatial

onready var cursor = get_node("Cursor")

func _ready():
	pass

func _on_mapContainer_input_event( camera, event, click_pos, click_normal, shape_idx ):
	var rounded_var = Vector3(round(click_pos.x), 1.02, round(click_pos.z))
	cursor.set_translation(rounded_var)