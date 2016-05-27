extends Panel

onready var gamescn = get_node("/root/Game").scene
onready var reputation_value = gamescn.player.reputation
onready var disease = gamescn.diseases
onready var diseases_list = disease.list_diseases

onready var hud = get_parent().get_node("HUD")

onready var node_informations = get_node("Book/Informations")
onready var node_container = get_node("Book/Buttons/ButtonsContainer")
onready var node_reputation = node_informations.get_node("Reputation/values")
onready var node_treatment = node_informations.get_node("TreatmentCharge/values")
onready var node_money = node_informations.get_node("MoneyEarned/values")
onready var node_recoveries = node_informations.get_node("Recoveries/values")
onready var node_fatalities = node_informations.get_node("Fatalities/values")
onready var node_turned = node_informations.get_node("TurnedAway/values")

onready var node_button_less = node_informations.get_node("TreatmentCharge/ButtonLess")
onready var node_button_more = node_informations.get_node("TreatmentCharge/ButtonMore")

onready var treatment_charge = 0
onready var money_earned = 0
onready var recoveries = 0
onready var fatalities = 0
onready var turned_away = 0
onready var percent = 100

var boolean = false

func _ready():
	connect_all_buttons()
	set_process(true)

func _on_Quit_pressed():
	self.hide()
	hud.show()

func update():
	if (self.is_visible()):
		node_reputation.set_text(str(reputation_value))
		
		if (boolean == false):
			node_treatment.set_text(str(treatment_charge))
		else:
			node_treatment.set_text(str(percent) + "%")
		node_money.set_text(str(money_earned))
		
		node_recoveries.set_text(str(recoveries))
		node_fatalities.set_text(str(fatalities))
		node_turned.set_text(str(turned_away))

func _process(delta):
	update()

func connect_all_buttons():
	var button
	for disease in diseases_list:
		if (diseases_list[disease].FOUND == true):
			button = Button.new()
			node_container.add_child(button)
			
			button.set_text(diseases_list[disease].NAME)
			button.connect("pressed", self, "disease_pressed",[diseases_list[disease]])
#			node_button_less.connect("pressed", self, "

func disease_pressed(disease):
	treatment_charge = disease.COST
	percent = disease.PERCENT
	money_earned = disease.MONEY_EARNED
	
	recoveries = disease.RECOVERIES
	fatalities = disease.FATALITIES
	turned_away = disease.TURNED_AWAY

#func decrease_cost(disease):
#	boolean = true
#	disease.PERCENT -= 1
#	get_node("Timer").start()
#
#func _on_Timer_timeout():
#	boolean = false
#	print("timer")
