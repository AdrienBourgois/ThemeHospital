extends Panel

onready var gamescn = get_node("/root/Game").scene
onready var camera = gamescn.camera
onready var reputation_value = gamescn.player.reputation
onready var disease = gamescn.diseases
onready var diseases_list = disease.list_diseases
onready var hud = get_parent().get_node("HUD")

onready var node_informations = get_node("Book/Informations")
onready var node_container = get_node("Book/Buttons/ButtonsContainer")
onready var node_timer = get_node("Timer")
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

var pos_container
var concentrate_research = false
var is_timer_finish = true

func _ready():
	connect_diseases_buttons()
	set_process(true)

func _on_Quit_pressed():
	self.hide()
	hud.show()
	camera.pause = false

func update():
	if (self.is_visible()):
		node_reputation.set_text(str(reputation_value))
		
		if (is_timer_finish == true):
			node_treatment.set_text(str(treatment_charge))
		else:
			node_treatment.set_text(str(percent) + "%")
		node_money.set_text(str(money_earned))
		
		node_recoveries.set_text(str(recoveries))
		node_fatalities.set_text(str(fatalities))
		node_turned.set_text(str(turned_away))

func _process(delta):
	update()

func connect_diseases_buttons():
	var button
	for disease in diseases_list:
		if (diseases_list[disease].FOUND == true):
			button = Button.new()
			node_container.add_child(button)
			
			
			button.set_text(diseases_list[disease].NAME)
			button.connect("pressed", self, "disease_pressed",[diseases_list[disease]])

func disease_pressed(disease):
	disconnect_buttons(node_button_less, "decrease_cost")
	disconnect_buttons(node_button_more, "increase_cost")
	
	if (!node_button_less.is_connected("pressed", self, "decrease_cost")):
		node_button_less.connect("pressed", self, "decrease_cost", [disease])
		
	if (!node_button_more.is_connected("pressed", self, "increase_cost")):
		node_button_more.connect("pressed", self, "increase_cost", [disease])
	
	if (node_timer.is_connected("timeout", self, "timer_timeout")):
		node_timer.disconnect("timeout", self, "timer_timeout")
	
	node_timer.connect("timeout", self, "timer_timeout", [disease])
	
	treatment_charge = disease.NEW_COST
	percent = disease.PERCENT
	money_earned = disease.MONEY_EARNED
	
	recoveries = disease.RECOVERIES
	fatalities = disease.FATALITIES
	turned_away = disease.TURNED_AWAY

func decrease_cost(disease):
	is_timer_finish = false
	
	if (disease.PERCENT > 0):
		disease.PERCENT -= 1
		percent = disease.PERCENT
		
		node_timer.start()

func increase_cost(disease):
	is_timer_finish = false
	
	disease.PERCENT += 1
	percent = disease.PERCENT
	
	node_timer.start()

func timer_timeout(disease):
	is_timer_finish = true
	
	disease.NEW_COST = percentage_calculation(disease.DEFAULT_COST, percent)
	treatment_charge = disease.NEW_COST


func percentage_calculation(value, percent):
	var new_value = value * (percent / 100.0)
	return int(new_value)

func _on_Concentrate_research_pressed():
	concentrate_research = true

func _on_Up_pressed():
	pos_container = node_container.get_pos()
	
	for button in node_container.get_children():
		if button.get_global_pos().y > 112 and button.get_global_pos().y < 495 and button.is_visible() == false:
			button.show()
			
		elif (button.get_global_pos().y < 112):
			button.hide()
			
		node_container.set_pos(Vector2(pos_container.x, pos_container.y - 10))


func _on_Down_pressed():
	pos_container = node_container.get_pos()
	
	for button in node_container.get_children():
		if button.get_global_pos().y < 495 and button.get_global_pos().y > 112 and button.is_visible() == false:
			button.show()
		
		elif (button.get_global_pos().y > 495):
			button.hide()
		
		node_container.set_pos(Vector2(pos_container.x, pos_container.y + 10))

func disconnect_buttons(button, method):
	if button.is_connected("pressed", self, method):
		button.disconnect("pressed", self, method)