extends Panel


onready var gamescn = get_node("/root/Game").scene
onready var camera = gamescn.camera
onready var reputation_value = gamescn.player.reputation
onready var disease = gamescn.diseases
onready var diseases_list = disease.list_diseases
onready var hud = get_parent().get_node("HUD")

onready var node_reputation = get_node("Book/Informations/Reputation/values")
onready var node_treatment = get_node("Book/Informations/TreatmentCharge/values")
onready var node_container = get_node("Book/Buttons/ButtonsContainer")
onready var node_money = get_node("Book/Informations/MoneyEarned/values")
onready var node_recoveries = get_node("Book/Informations/Recoveries/values")
onready var node_fatalities = get_node("Book/Informations/Fatalities/values")
onready var node_turned = get_node("Book/Informations/TurnedAway/values")

onready var treatment_charge = 0
onready var money_earned = 0
onready var recoveries = 0
onready var fatalities = 0
onready var turned_away = 0

func _ready():
	connect()
	set_process(true)

func _on_Quit_pressed():
	self.hide()
	hud.show()
	camera.pause = false

func update():
	node_reputation.set_text(str(reputation_value))
	node_treatment.set_text(str(treatment_charge))
	node_money.set_text(str(money_earned))
	node_recoveries.set_text(str(recoveries))
	node_fatalities.set_text(str(fatalities))
	node_turned.set_text(str(turned_away))

func _process(delta):
	update()

func connect():
	var button
	for disease in diseases_list:
		if (diseases_list[disease].FOUND == true):
			button = Button.new()
			node_container.add_child(button)
			
			button.set_text(diseases_list[disease].NAME)
			button.connect("pressed", self, "disease_pressed",[diseases_list[disease]])
			

func disease_pressed(disease):
	treatment_charge = disease.COST
	money_earned = disease.MONEY_EARNED
	recoveries = disease.RECOVERIES
	fatalities = disease.FATALITIES
	turned_away = disease.TURNED_AWAY