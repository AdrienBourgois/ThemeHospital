
extends Node

var socket = null
var peer_stream = null
var messages_list = Array() setget ,get_messages_list

var client_states = {
	is_connected = false,
	is_connecting = false,
	is_host = false
}

func _ready():
	pass

func connect_to_server(ip_address, port):
	socket = StreamPeerTCP.new()
	var status_connection = socket.connect(ip_address, port)
	
	client_states.is_connecting = true
	
	return check_socket_status()
	
	pass

func check_socket_status():
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
		print("Aucune idee frere")
		return false

func send_packet(packet):
	if (client_states.is_connected):
		peer_stream.put_var(packet)

func get_messages_list():
	return messages_list

func set_host_client(boolean):
	client_states.is_host = boolean