
extends Control

onready var global_client = get_node("/root/GlobalClient")
onready var global_server = get_node("/root/GlobalServer")
onready var game = get_node("/root/Game")
var missed_messages_label = null
onready var messages_list_label = get_node("./chat_box/messages_list_label")
onready var message_line_edit = get_node("./chat_box/message_line_edit")
onready var send_message_button = get_node("./chat_box/send_message_button")
onready var in_game_chat_controls = get_node("./in_game_chat_controls")
onready var move_button = in_game_chat_controls.get_node("./move_button")
onready var resize_button = in_game_chat_controls.get_node("./resize_button")
var chat_settings = null
var never_show_chat = false
var last_messages_list_size = 0
var messages_missed = 0
var vector_move_button = null
var vector_viewport = 0

func _ready():
	checkMultiplayer()
	toggleVisibility()
	set_process_input(true)


func _process(delta):
	updateChat()


func initChatSettingsVariables():
	chat_settings = game.scene.get_node("In_game_gui/HUD/MenuBar")
	missed_messages_label= chat_settings.get_node("Chat_settings_button/Messages_missed_label")


func checkMultiplayer():
	if ( game.getMultiplayer() ):
		messages_list_label.set_scroll_follow(true)
		set_process(true)
	else:
		never_show_chat = true


func toggleVisibility():
	if ( !never_show_chat ):
		set_hidden( is_visible() )
		if (chat_settings != null):
			chat_settings.setChatVisibility( is_visible() )
		
		if (is_visible()):
			messages_missed = 0
			updateMissedMessage()


func setControlsVisibility( boolean ):
	in_game_chat_controls.set_hidden( !boolean )


func updateChat():
	var messages_list = global_client.getMessagesList()
	
	if ( last_messages_list_size != messages_list.size() ):
		addMissedMessage()
		last_messages_list_size = messages_list.size()
		messages_list_label.clear()
		for message in range (messages_list.size()):
			messages_list_label.add_text(messages_list[message])
		
		updateMissedMessage()


func addMissedMessage():
	if ( last_messages_list_size == 0):
		return
	if ( !is_visible() ):
			messages_missed += 1


func updateMissedMessage():
	if (missed_messages_label != null):
		missed_messages_label.set_text("(" + str(messages_missed) + ")")


func checkForEmptyMessage(message):
	if ( message.empty() ):
		return true
	
	for character in range ( message.length() ):
		if ( message[character] != ' ' ):
			return false
	
	return true


func parseSpaces(message):
	for character in range (message.length()):
		if (message[character] != ' '):
			return message.substr(character, message.length())


func _on_message_line_edit_input_event( event ):
	if ( event.is_action_pressed("accept") ):
		_on_send_message_button_pressed()


func _on_send_message_button_pressed():
	var message = message_line_edit.get_text()
	
	if ( !checkForEmptyMessage(message) ):
		var new_message = "/chat " + parseSpaces(message) + "\n"
		global_client.sendPacket(new_message)
		message_line_edit.clear()


func toggleSendMessageButton( boolean ):
	if ( boolean ):
		send_message_button.set_hidden(boolean)
		message_line_edit.set_margin(MARGIN_RIGHT, 0.987)
	else:
		send_message_button.set_hidden(boolean)
		message_line_edit.set_margin(MARGIN_RIGHT, 0.787)


func _on_move_button_input_event( ev ):
	if (ev.type == 1):
		return
	
	if ( move_button.is_pressed() ):
		getMoveButtonPressed( ev.pos )
		
		vector_viewport = Vector2(get_viewport().get_mouse_pos().x, get_viewport().get_mouse_pos().y)
		checkInGameChatPos(Vector2(vector_viewport.x - vector_move_button.x, vector_viewport.y - vector_move_button.y))
	elif ( !move_button.is_pressed() ):
		resetMoveButton()


func getMoveButtonPressed( mouse_pos ):
	if ( vector_move_button == null ):
			vector_move_button = Vector2(mouse_pos.x, mouse_pos.y)


func resetMoveButton():
	vector_move_button = null


func checkInGameChatPos(pos):
	var window_size_x = OS.get_window_size().x
	var window_size_y = OS.get_window_size().y
	
	if ( pos.x <= -1):
		pos.x = 0
	if ( pos.y <= -1):
		pos.y = 0
	if ( pos.x + get_size().x >= window_size_x ):
		pos.x = window_size_x - get_size().x
	if ( pos.y + get_size().y >= window_size_y ):
		pos.y = window_size_y - get_size().y
	
	set_pos(pos)


func _on_resize_button_input_event( ev ):
	if ( resize_button.is_pressed() ):
		getResizeButtonPressed( ev.pos )
		
		vector_viewport = Vector2(get_viewport().get_mouse_pos().x, get_viewport().get_mouse_pos().y)
		checkInGameChatSize(Vector2(vector_viewport.x + vector_move_button.x, vector_viewport.y + vector_move_button.y))
	elif ( !resize_button.is_pressed() ):
		resetMoveButton()


func getResizeButtonPressed( mouse_pos ):
	if ( vector_move_button == null):
		vector_move_button = Vector2(resize_button.get_size().x - mouse_pos.x, resize_button.get_size().y - mouse_pos.y)


func checkInGameChatSize( mouse_pos ):
	var final_size_x = mouse_pos.x - get_pos().x
	var final_size_y = mouse_pos.y - get_pos().y
	
	if (get_viewport().get_mouse_pos().x > OS.get_window_size().x):
		final_size_x = OS.get_window_size().x - get_pos().x
	if (get_viewport().get_mouse_pos().y > OS.get_window_size().y):
		final_size_y = OS.get_window_size().y - get_pos().y
	
	set_size( Vector2( final_size_x, final_size_y ) )
	resize_button.set_pos(Vector2(get_size().x - resize_button.get_size().x, get_size().y - resize_button.get_size().y))

func resetChatPos():
	set_size(Vector2(400,280))
	set_margin(MARGIN_LEFT, 0.596)
	set_margin(MARGIN_TOP, 0.033)
	set_margin(MARGIN_RIGHT, 0.986)
	set_margin(MARGIN_BOTTOM, 0.5)
