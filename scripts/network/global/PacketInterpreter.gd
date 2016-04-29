
extends Node

var tmpData = Array()

func _ready():
	pass

func parsePacket(packet):
	storeData(packet)
	pass

func storeData(packet):
	tmpData.clear()
	var data = ""
	
	for character in range (packet.length()):
		if (packet[character] != ' '):
			data += packet[character]
		else:
			if (!data.empty()):
				tmpData.push_back(data)
				data = ""
	
	tmpData.push_back(data)
