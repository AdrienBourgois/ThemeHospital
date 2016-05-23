
extends Node

var socket = null
var peer_stream = null 
var client_id = null setget setClientId,getClientId
var messages_list = Array() setget addMessage,getMessagesList
var packet_list = Array() setget addPacket
onready var packet_interpreter = get_node("/root/PacketInterpreter")

var client_states = {
	is_connected = false,
	is_connecting = false,
	is_host = false
} setget ,getClientStates

func _process(delta):
	if (client_states.is_connected):
		checkForMessage()
		checkForDisconnection()
		checkForPacketToSend()
	elif (client_states.is_connecting):
		checkSocketStatus()

func connectToServer(ip_address, port):
	if (!client_states.is_connected && !client_states.is_connecting):
		client_states.is_connecting = true
		socket = StreamPeerTCP.new()
		var status_connection = socket.connect(ip_address, port)
		
		checkSocketStatus()


func checkSocketStatus():
	if (socket == null):
		set_process(false)
		return
	
	var connection_status = socket.get_status()
	
	if (connection_status == StreamPeerTCP.STATUS_CONNECTED):
		initializeConnection()
	elif (connection_status == StreamPeerTCP.STATUS_CONNECTING):
		var root = get_tree().get_current_scene()
		
		if ( root != null && root.get_name() == "client_settings_gui" ):
			root.display_connecting_to_server()
		
		set_process(true)
	else:
		set_process(false)


func initializeConnection():
	client_states.is_connected = true
	client_states.is_connecting = false
	peer_stream = PacketPeerStream.new()
	peer_stream.set_stream_peer(socket)
	
	set_process(true)

func checkForMessage():
	if ( peer_stream != null && peer_stream.get_available_packet_count() > 0 ):
		var message = peer_stream.get_var()
		packet_interpreter.addClientPacket(message)


func checkForDisconnection():
	if ( !socket.is_connected() ):
		disconnectFromServer()
		var scene = load("res://scenes/network/WarningServerDisconnected.scn").instance()
		scene.displayUnavailableServer()
		get_tree().get_current_scene().add_child(scene, true)


func checkForPacketToSend():
	if ( packet_list.size() > 0 ):
		if ( sendPacket(packet_list[0]) ):
			packet_list.remove(0)

func sendPacket(packet):
	if ( client_states.is_connected ):
		peer_stream.put_var(packet)
		return true
	else:
		return false

func addMessage(message):
	messages_list.push_back(message)

func getMessagesList():
	return messages_list

func setHostClient(boolean):
	client_states.is_host = boolean

func getClientStates():
	return client_states

func disconnectServer():
	if (client_states.is_host):
		var global_server = get_node("/root/GlobalServer").stopServer()

func resetClientStates():
	client_states.is_connected = false
	client_states.is_connecting = false
	client_states.is_host = false

func disconnectFromServer():
	if (socket != null):
		socket.disconnect()
	
	messages_list.clear()
	packet_list.clear()
	
	disconnectServer()
	resetClientStates()
	
	client_id = null
	peer_stream = null
	socket = null


func setClientId(id):
	if (client_id == null):
		client_id = id

func getClientId():
	return client_id


func addPacket(packet):
	packet_list.push_back(packet)


func mutePlayer(player_id):
	addPacket("/game 9 1 " + str(player_id))


func unmutePlayer(player_id):
	addPacket("/game 9 0 " + str(player_id))