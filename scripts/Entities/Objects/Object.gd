
extends "../Entity.gd"

export var price = 100
export var expense_per_month = 0

export var in_room_object = false

func _ready():
	pass

func _on_Entity_input_event( camera, event, click_pos, click_normal, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click") && can_selected == true:
		can_selected = false
		set_process_input(false)
	elif event.type == InputEvent.MOUSE_BUTTON && event.is_action_released("right_click") && can_selected == false:
		if (in_room_object):
			return
		is_selected = true
		can_selected = true
		set_process_input(true)
