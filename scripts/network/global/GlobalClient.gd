
extends Node

var socket = null
var peer_stream = null
var messages_list = Array() setget ,get_messages_list

var client_states = {
	is_connected = false,
	is_connecting = false
}

func _ready():
	set_process(true)
	pass

func _process(delta):
	if (client_states.is_connected):
		print("Je balance le packet monsieur")
		peer_stream.put_var("Bonsoir monsieur")
		set_process(false)

func connect_to_server(ip_address, port):
	socket = StreamPeerTCP.new()
	peer_stream = PacketPeerStream.new()
	client_states.is_connecting = true
	
	if (socket.connect(ip_address, port) == 0):
		client_states.is_connected = true
		client_states.is_connecting = false
		peer_stream.set_stream_peer(socket)
		print("Connected to server")
	else:
		print("couldn't connect to server")
	
	pass

func get_messages_list():
	return messages_list