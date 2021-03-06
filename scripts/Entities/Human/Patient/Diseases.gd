extends Node

onready var name = ""
onready var type = ""

onready var disease = get_node("/root/Game").scene.diseases
onready var pharmacy = disease.cure_at_pharmacy
onready var psychatric = disease.cure_at_psychiatric
onready var clinics = disease.cure_at_clinics
onready var disease_array = [pharmacy, psychatric, clinics]
onready var disease_type_array = ["pharmacy", "psychatric", "clinics"]

var disease_type

func _ready():
	randomize()
	setDisease()

func setDisease():
	var rand_type = randi()%3
	disease_type = disease_array[rand_type]
	disease_type = disease_type[randi()%disease_type.size()]
	name = disease_type["NAME"]