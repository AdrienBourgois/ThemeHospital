
extends Node

export(StringArray) var pharmacy = []
export(StringArray) var psychatric = []
export(StringArray) var clinics = []

onready var name = "" setget ,getName
onready var type = "" setget ,getType
onready var disease_array = [pharmacy, psychatric, clinics]
onready var disease_type_array = ["pharmacy", "psychatric", "clinics"]

func _ready():
	setDisease()

func setDisease():
	var rand_type = randi()%2
	var disease_type = disease_array[rand_type]
	name = type[randi()%type.size()]
	type = disease_type_array[rand_type]
	print(disease, "  ", disease_type)

func getName():
	return name

func getType():
	return type