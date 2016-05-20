
extends Control

onready var port_node = get_node("./panel/combo_box/port_spin_box")
onready var ip_address_node = get_node("./panel/combo_box/ip_address_line_edit")
onready var nickname_node = get_node("./panel/combo_box/nickname_line_edit")
onready var global_client = get_node("/root/GlobalClient")
onready var control_node = get_node("panel/Control")
onready var connecting_popup = control_node.get_node("connecting_to_server")
onready var invalid_popup = control_node.get_node("invalid_server")
onready var game = get_node("/root/Game")
onready var timer = get_node("./timer")
onready var timer_label = control_node.get_node("connecting_to_server/timer_label")

func _ready():
	setUsername()

func _process(delta):
	updateTimer()

func _on_join_server_button_pressed():
	if (port_node == null || ip_address_node == null):
		return
	
	if ( !checkValidIpAddress() || !checkValidNickname()):
		return
	
	global_client.connectToServer(ip_address_node.get_text(), port_node.get_value())
	global_client.addPacket("/nickname " + nickname_node.get_text())



func _on_back_to_main_menu_button_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/network/MultiplayerSelectMenu.scn")


func checkInputEvent( ev ):
	if (ev.is_action_pressed("accept")):
		_on_join_server_button_pressed()


func checkValidIpAddress():
	var ip_address = ip_address_node.get_text()
	
	if ( ip_address.empty() || !ip_address.is_valid_ip_address() ):
		control_node.set_hidden(false)
		control_node.get_node("invalid_server").set_hidden(false)
		return false
	
	return true


func checkValidNickname():
	var nickname = nickname_node.get_text()
	
	if (nickname.empty()):
		displayInvalidNickname()
		return false
	
	for character in range ( nickname.length() ):
		if (nickname[character] != ' '):
			return true
	
	displayInvalidNickname()
	return false

func displayInvalidNickname():
	var node = ResourceLoader.load("res://scenes/network/InvalidNickname.scn").instance()
	get_tree().get_current_scene().add_child(node)


func _on_ok_button_pressed():
	global_client.disconnectFromServer()
	control_node.set_hidden(true)
	connecting_popup.set_hidden(true)
	invalid_popup.set_hidden(true)


func display_connecting_to_server():
	if ( control_node.is_visible() ):
		return
	
	control_node.set_hidden(false)
	connecting_popup.set_hidden(false)
	connecting_popup.get_ok().grab_focus()


func display_invalid_server():
	if ( control_node.is_visible() ):
		return
	
	control_node.set_hidden(false)
	invalid_popup.set_hidden(false)
	invalid_popup.get_ok().grab_focus()

func setUsername():
	if (game != null):
		nickname_node.set_text(game.getUsername())

func _on_connecting_to_server_visibility_changed():
	timer.start()
	set_process(true)


func _on_timer_timeout():
	_on_invalid_server_confirmed()
	set_process(false)

func updateTimer():
	var time_left = int(timer.get_time_left())
	timer_label.set_text(str(time_left))
