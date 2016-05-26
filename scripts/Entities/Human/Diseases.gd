extends Node

onready var name = "" setget ,getName
onready var type = "" setget ,getType

onready var diseases = preload("res://scripts/Entities/Human/DiseasesDictionaries.gd").new()
onready var pharmacy = diseases.cure_at_pharmacy
onready var psychatric = diseases.cure_at_psychiatric
onready var clinics = diseases.cure_at_clinics
onready var disease_array = [pharmacy, psychatric, clinics]
onready var disease_type_array = ["pharmacy", "psychatric", "clinics"]

func _ready():
	randomize()
	setDisease()

func setDisease():
	var rand_type = randi()%2
	var disease_type = disease_array[rand_type]
	disease_type[randi()%disease_type.size()]
	disease_type_array[rand_type]

func getName():
	return name

func getType():
	return type