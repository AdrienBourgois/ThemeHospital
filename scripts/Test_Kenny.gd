extends Spatial

onready var cursor = get_node("Map_container/Cursor")

func _ready():
	pass

#func _on_mapContainer_input_event( camera, event, click_pos, click_normal, shape_idx ):
#	var rounded_var = Vector3(round(click_pos.x), 1.02, round(click_pos.z))
#
#	cursor.set_translation(rounded_var)

func _on_Map_container_input_event( camera, event, click_pos, click_normal, shape_idx ):
	print("here")
	pass # replace with function body
