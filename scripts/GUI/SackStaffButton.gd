
extends Button

func _on_SackButton_pressed():
	get_parent().hide()
	get_node("ConfirmationDialog").show()
