extends Panel

onready var gamescn = get_node("/root/Game").scene
onready var camera = gamescn.camera
onready var reputation_value = gamescn.player.reputation
onready var game_diseases = gamescn.diseases
onready var diseases_list = game_diseases.list_diseases
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
onready var node_selector = get_node("Book/Buttons/Selector")

onready var node_button_up = get_node("Book/Buttons/Up")
onready var node_button_down = get_node("Book/Buttons/Down")
onready var node_decrease = node_informations.get_node("TreatmentCharge/DecreaseCost")
onready var node_increase = node_informations.get_node("TreatmentCharge/IncreaseCost")

onready var treatment_charge = 0
onready var money_earned = 0
onready var recoveries = 0
onready var fatalities = 0
onready var turned_away = 0
onready var percent = 100

var array_diseases = []
var dis_idx = 0
var basic_pos_button = 0
var button_pos = 0
var pos_container
var pos_selector
var size_container

var concentrate_research = false
var disease_selected = false
var is_timer_finish = true

func _ready():
	pos_container = node_container.get_pos()
	pos_selector = node_selector.get_pos()
	size_container = node_container.get_size()
	
	connectDiseasesButtonsAndTimer()
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

func connectDiseasesButtonsAndTimer():
	var button
	var button_number = -1
	
	for disease in diseases_list:
		if (diseases_list[disease].FOUND == true):
			
			if array_diseases.size() > button_number:
				button_number += 1
			
			button = Button.new()
			node_container.add_child(button)
			button.set_meta("button_number", button_number)
			
			array_diseases.push_back(diseases_list[disease])
			
			configDiseasesButtons(button, diseases_list[disease].NAME)

func diseasePressed(button):
	disconnectFunc("pressed", node_decrease, "decreaseCostPressed")
	disconnectFunc("pressed", node_increase, "increaseCostPressed")
	disconnectFunc("timeout", node_timer, "timerTimeout")
	
	node_decrease.connect("pressed", self, "decreaseCostPressed", [array_diseases[button.get_meta("button_number")]])
	node_increase.connect("pressed", self, "increaseCostPressed", [array_diseases[button.get_meta("button_number")]])
	node_timer.connect("timeout", self, "timerTimeout", [array_diseases[button.get_meta("button_number")]])
	
	treatment_charge = array_diseases[button.get_meta("button_number")].NEW_COST
	percent = array_diseases[button.get_meta("button_number")].PERCENT
	money_earned = array_diseases[button.get_meta("button_number")].MONEY_EARNED
	
	recoveries = array_diseases[button.get_meta("button_number")].RECOVERIES
	fatalities = array_diseases[button.get_meta("button_number")].FATALITIES
	turned_away = array_diseases[button.get_meta("button_number")].TURNED_AWAY
	
	disease_selected = true

func percentageCalculation(value, percent):
	var new_value = value * (percent / 100.0)
	return int(new_value)

func _on_Concentrate_research_pressed():
	concentrate_research = true

func configDiseasesButtons(button, disease_name):
	button.set_margin(MARGIN_LEFT, 0)
	button.set_margin(MARGIN_TOP, 0)
	button.set_margin(MARGIN_BOTTOM, 19)
	button.set_margin(MARGIN_RIGHT, size_container.x)
	
	button.set_anchor(MARGIN_LEFT, ANCHOR_RATIO)
	button.set_anchor(MARGIN_BOTTOM, ANCHOR_RATIO)
	button.set_anchor(MARGIN_RIGHT, ANCHOR_RATIO)
	button.set_anchor(MARGIN_TOP, ANCHOR_RATIO)
	
	button.set_pos(Vector2(button.get_margin(MARGIN_LEFT), (pos_selector.y + 5) + basic_pos_button - pos_container.y))
	
	button.set_text(disease_name)
	button.connect("pressed", self, "diseasePressed", [button])
	
	basic_pos_button += 23.0
	
	button_pos = button.get_pos()
	
	if button_pos.y == (pos_selector.y + 5.0) - pos_container.y:
		button.emit_signal("pressed")
		button.set_toggle_mode(true)
		button.set_pressed(true)

func _on_Up_pressed():
	is_timer_finish = false
	
	for button in node_container.get_children():
		button_pos = button.get_pos()
		
		disconnectFunc("pressed", node_decrease, "decreaseCostPressed")
		disconnectFunc("pressed", node_increase, "increaseCostPressed")
		disconnectFunc("timeout", node_timer, "timerTimeout")
		
		if (dis_idx > 0):
			button_pos.y += 23
			button.set_pos(button_pos)
			print("Up pos")
		
		if button_pos.y < node_button_up.get_pos().y or button_pos.y > size_container.y:
			button.hide()
		
		else:
			button.show() 
		
		if button_pos.y == (pos_selector.y + 5) - pos_container.y:
			if (dis_idx > 0):
				print("Dis_idx up : ", dis_idx)
				dis_idx -= 1
				print("Dis_idx in up after : ", dis_idx)
			
			node_decrease.connect("pressed", self, "decreaseCostPressed", [array_diseases[dis_idx]])
			node_increase.connect("pressed", self, "increaseCostPressed", [array_diseases[dis_idx]])
			node_timer.connect("timeout", self, "timerTimeout", [array_diseases[dis_idx]])
			
			button.emit_signal("pressed")
			button.set_toggle_mode(true)
			button.set_pressed(true)
		
		else:
			button.set_pressed(false)
			button.set_toggle_mode(false)
	
	node_timer.start()

func _on_Down_pressed():
	is_timer_finish = false
	
	for button in node_container.get_children():
		button_pos = button.get_pos()
		
		disconnectFunc("pressed", node_decrease, "decreaseCostPressed")
		disconnectFunc("pressed", node_increase, "increaseCostPressed")
		disconnectFunc("timeout", node_timer, "timerTimeout")
		
		if dis_idx < array_diseases.size() - 1:
			button_pos.y -= 23
			button.set_pos(button_pos)
			print("Down pos")
		
		if button_pos.y < node_button_up.get_pos().y or button_pos.y > size_container.y:
			button.hide()
		
		else:
			button.show() 
		
		if button_pos.y == (pos_selector.y + 5) - pos_container.y:
			if dis_idx < array_diseases.size() - 1:
				print("Dis_idx in down b4 : ", dis_idx)
				dis_idx += 1
				print("Dis_idx in down after : ", dis_idx)
			
			node_decrease.connect("pressed", self, "decreaseCostPressed", [array_diseases[dis_idx]])
			node_increase.connect("pressed", self, "increaseCostPressed", [array_diseases[dis_idx]])
			node_timer.connect("timeout", self, "timerTimeout", [array_diseases[dis_idx]])
			
			button.emit_signal("pressed")
			button.set_toggle_mode(true)
			button.set_pressed(true)
		
		else:
			button.set_pressed(false)
			button.set_toggle_mode(false)
	 
	node_timer.start()

func disconnectFunc(type, button, method):
	if button.is_connected(type, self, method):
		button.disconnect(type, self, method)

func timerTimeout(disease):
	disease.NEW_COST = percentageCalculation(disease.DEFAULT_COST, percent)
	treatment_charge = disease.NEW_COST
	
	is_timer_finish = true

func increaseCostPressed(disease_selected):
	is_timer_finish = false
	
	disease_selected.PERCENT += 1
	percent = disease_selected.PERCENT
	
	node_timer.start()

func decreaseCostPressed(disease_selected):
	is_timer_finish = false
	
	if (disease_selected.PERCENT > 0):
		disease_selected.PERCENT -= 1
		percent = disease_selected.PERCENT
		
		node_timer.start()