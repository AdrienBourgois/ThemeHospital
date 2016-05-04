extends Control

onready var game = get_node("/root/Game")
onready var loader = get_node("/root/Load")

func _ready():
	loader.loadInit()
	print("Username : ", game.username)

func _on_New_game_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/gamescn.scn")


func _on_Load_game_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/GUI/LoadMenu.scn")


func _on_Multiplayer_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/network/MultiplayerSelectMenu.scn")


func _on_Options_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/GUI/OptionsMenu.scn")


func _on_Quit_pressed():
	get_tree().quit()