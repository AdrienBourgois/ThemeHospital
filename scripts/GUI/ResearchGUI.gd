extends Panel

var global_value
var cure_equipment = 20
var diagnosis = 20
var drugs = 20
var improvements = 20
var specialisation = 20

onready var informations = get_node("Informations")

func _ready():
	global_value = cure_equipment + diagnosis + drugs + improvements + specialisation
	set_values()

func set_values():
	informations.get_node("CureEquipement").set_value(cure_equipment)
	informations.get_node("DiagnosisEquipment").set_value(diagnosis)
	informations.get_node("DrugResearch").set_value(drugs)
	informations.get_node("Improvements").set_value(improvements)
	informations.get_node("Specialisation").set_value(specialisation)
	get_node("Total").set_value(global_value)