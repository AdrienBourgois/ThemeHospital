extends Node

onready var name = "" setget ,getName
onready var type = "" setget ,getType

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
	var rand_type = randi()%2
	disease_type = disease_array[rand_type]
	disease_type = disease_type[randi()%disease_type.size()]
#	disease_type_array[rand_type]
	name = disease_type["NAME"]


func getName():
	return name

func getType():
	return type

func get_pharmacy_disease():
	return pharmacy

func get_psychatric_disease():
	return psychatric

func get_clinics_disease():
	return clinics