
extends Node

var socket = null
var peer_stream = null 
var client_id = null setget setClientId,getClientId
var messages_list = Array() setget addMessage,getMessagesList
var packet_list = Array() setget addPacket

var client_states = {
	is_connected = false,
	is_connecting = false,
	is_host = false
} setget ,getClientStates

func _ready():
	set_process(true)

func _process(delta):
	checkForMessage()
	checkForPacketToSend()

func connectToServer(ip_address, port):
	socket = StreamPeerTCP.new()
	var status_connection = socket.connect(ip_address, port)
	
	client_states.is_connecting = true
	
	return checkSocketStatus()
	
	pass

func checkSocketStatus():
	if (socket == null || !client_states.is_connecting):
		return false
	
	var connection_status = socket.get_status()
	
	if (connection_status == 0 || connection_status == 2):
		initializeConnection()
		return true
	elif (connection_status == 1):
		print("Still connecting to server ...")
		return false
	elif (connection_status == 3):
		print("there was an error while connecting to server")
		return false
	else:
		return false

func initializeConnection():
	client_states.is_connected = true
	client_states.is_connecting = false
	peer_stream = PacketPeerStream.new()
	peer_stream.set_stream_peer(socket)

func checkForMessage():
	if (peer_stream != null && peer_stream.get_available_packet_count() > 0):
		var message = peer_stream.get_var()
		get_node("/root/PacketInterpreter").addClientPacket(message)

func checkForPacketToSend():
	if (packet_list.size() > 0):
		sendPacket(packet_list[0])
		packet_list.remove(0)

func sendPacket(packet):
	if (client_states.is_connected):
		peer_stream.put_var(packet)

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
	socket.disconnect()
	messages_list.clear()
	
	disconnectServer()
	resetClientStates()
	
	peer_stream = null
	socket = null


func setClientId(id):
	if (client_id == null):
		client_id = id

func getClientId():
	return client_id


func addPacket(packet):
	packet_list.push_back(packet)