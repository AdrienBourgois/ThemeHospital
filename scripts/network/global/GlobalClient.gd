
extends Node

var socket = null
var peer_stream = null
var messages_list = Array() setget ,getMessagesList

var client_states = {
	is_connected = false,
	is_connecting = false,
	is_host = false
}

func _ready():
	set_process(true)
	pass

func _process(delta):
	checkForMessage()

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
		client_states.is_connected = true
		client_states.is_connecting = false
		peer_stream = PacketPeerStream.new()
		peer_stream.set_stream_peer(socket)
		print("Connected to server")
		return true
	elif (connection_status == 1):
		print("Still connecting to server ...")
		return false
	elif (connection_status == 3):
		print("there was an error while connecting to server")
		return false
	else:
		return false

func checkForMessage():
	if (peer_stream != null && peer_stream.get_available_packet_count() > 0):
		var message = peer_stream.get_var()
		messages_list.push_back(message)

func sendPacket(packet):
	if (client_states.is_connected):
		peer_stream.put_var(packet)

func getMessagesList():
	return messages_list

func setHostClient(boolean):
	client_states.is_host = boolean
