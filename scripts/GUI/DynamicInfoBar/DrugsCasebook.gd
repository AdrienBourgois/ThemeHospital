extends Panel

onready var gamescn = get_node("/root/Game").scene
onready var camera = gamescn.camera
onready var reputation_value = gamescn.player.reputation
onready var diseases_list = gamescn.diseases.list_diseases
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

var first_button_pos
var second_button_pos
var button_gap = 0
var selector_border_size

var concentrate_research = false
var disease_selected = false
var is_timer_finish = true
var is_pressed = true

func _ready():
	pos_container = node_container.get_pos()
	pos_selector = node_selector.get_pos()
	size_container = node_container.get_size()
	
	selector_border_size = node_selector.get("custom_styles/panel").get_border_size()
	
	get_node("/root").connect("size_changed", self, "refreshVariablesIfSizeChange")
	
	connectDiseasesButtons()
	
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

func connectDiseasesButtons():
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
	disconnectDecreaseAndIncrease()
	if node_timer.is_connected("timeout", self, "timerTimeout"):
		node_timer.disconnect("timeout", self, "timerTimeout")
	
	node_timer.connect("timeout", self, "timerTimeout", [array_diseases[button.get_meta("button_number")]])
	connectDecreaseAndIncrease(array_diseases[button.get_meta("button_number")])
	
	treatment_charge = array_diseases[button.get_meta("button_number")].NEW_COST
	percent = array_diseases[button.get_meta("button_number")].PERCENT
	money_earned = array_diseases[button.get_meta("button_number")].MONEY_EARNED
	
	recoveries = array_diseases[button.get_meta("button_number")].RECOVERIES
	fatalities = array_diseases[button.get_meta("button_number")].FATALITIES
	turned_away = array_diseases[button.get_meta("button_number")].TURNED_AWAY
	
	if is_pressed == false:
		var idx = 0
		
		button_pos = button.get_pos()
		var selector_pos = pos_selector.y + selector_border_size - pos_container.y
		var gap_button_selector = selector_pos - button_pos.y
		
		if button_pos.y != selector_pos:
			for buttons in node_container.get_children():
				button_pos = buttons.get_pos()
				button_pos.y += gap_button_selector
				buttons.set_pos(button_pos)
				
				if button_pos.y == selector_pos:
					setButtonPressed(button, true, true)
				else:
					setButtonPressed(button, false, false)
		else:
			setButtonPressed(button, true, true)
	
	is_pressed = false
	disease_selected = true

func percentageCalculation(value, percent):
	var new_value = value * (percent / 100.0)
	return int(new_value)

func _on_Concentrate_research_pressed():
	concentrate_research = true

func configDiseasesButtons(button, disease_name):
	button.set_margin(MARGIN_LEFT, 0)
	button.set_margin(MARGIN_TOP, 0)
	button.set_margin(MARGIN_BOTTOM, button.get_size().y)
	button.set_margin(MARGIN_RIGHT, size_container.x)
	
	button.set_anchor(MARGIN_LEFT, ANCHOR_RATIO)
	button.set_anchor(MARGIN_BOTTOM, ANCHOR_RATIO)
	button.set_anchor(MARGIN_RIGHT, ANCHOR_RATIO)
	button.set_anchor(MARGIN_TOP, ANCHOR_RATIO)
	
	button.set_size(Vector2(node_selector.get_size().x, node_selector.get_size().y - selector_border_size))
	button.set_pos(Vector2(button.get_margin(MARGIN_LEFT), (pos_selector.y + selector_border_size) + basic_pos_button - pos_container.y))
	
	button.set_text(disease_name)
	button.connect("pressed", self, "diseasePressed", [button])
	
	basic_pos_button += node_selector.get_size().y + selector_border_size
	
	button_pos = button.get_pos()
	
	if button_pos.y == (pos_selector.y + selector_border_size) - pos_container.y:
		ButtonPressed(button)

func _on_Up_pressed():
	is_timer_finish = false
	
	first_button_pos = node_container.get_child(0).get_pos()
	second_button_pos = node_container.get_child(1).get_pos()
	
	selector_border_size = node_selector.get("custom_styles/panel").get_border_size()
	button_gap = second_button_pos.y - first_button_pos.y
	
	for button in node_container.get_children():
		button_pos = button.get_pos()
		
		is_pressed = true
		
#		if (dis_idx > 0):
		button_pos.y += button_gap
		button.set_pos(button_pos)
		
		if button_pos.y < node_button_up.get_pos().y or button_pos.y > size_container.y:
			button.hide()
		
		else:
			button.show() 
		
		if button_pos.y == (pos_selector.y + selector_border_size) - pos_container.y:
			if (dis_idx > 0):
				dis_idx -= 1
			
			if node_timer.is_connected("timeout", self, "timerTimeout"):
				node_timer.disconnect("timeout", self, "timerTimeout")
			disconnectDecreaseAndIncrease()
			
			node_timer.connect("timeout", self, "timerTimeout", [array_diseases[dis_idx]])
			connectDecreaseAndIncrease(array_diseases[dis_idx])
			
			ButtonPressed(button)
		
		else:
			setButtonPressed(button, false, false)
	
	node_timer.start()

func _on_Down_pressed():
	is_timer_finish = false
	
	first_button_pos = node_container.get_child(0).get_pos()
	second_button_pos = node_container.get_child(1).get_pos()
	
	selector_border_size = node_selector.get("custom_styles/panel").get_border_size()
	button_gap = second_button_pos.y - first_button_pos.y
	
	for button in node_container.get_children():
		button_pos = button.get_pos()
		
		is_pressed = true
		
#		if dis_idx < array_diseases.size() - 1:
		button_pos.y -= button_gap
#			print("Down : ", button_pos)
		button.set_pos(button_pos)
#			print("Down pos")
		
		if button_pos.y < node_button_up.get_pos().y or button_pos.y > size_container.y:
			button.hide()
		
		else:
			button.show() 
		
		if button_pos.y == (pos_selector.y + selector_border_size) - pos_container.y:
			if dis_idx < array_diseases.size() - 1:
				dis_idx += 1
			
			if node_timer.is_connected("timeout", self, "timerTimeout"):
				node_timer.disconnect("timeout", self, "timerTimeout")
			disconnectDecreaseAndIncrease()
			
			node_timer.connect("timeout", self, "timerTimeout", [array_diseases[dis_idx]])
			connectDecreaseAndIncrease(array_diseases[dis_idx])
			
			ButtonPressed(button)
		
		else:
			setButtonPressed(button, false, false)
	 
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

func disconnectDecreaseAndIncrease():
	disconnectFunc("pressed", node_decrease, "decreaseCostPressed")
	disconnectFunc("pressed", node_increase, "increaseCostPressed")

func connectDecreaseAndIncrease(array_dis):
	node_decrease.connect("pressed", self, "decreaseCostPressed", [array_dis])
	node_increase.connect("pressed", self, "increaseCostPressed", [array_dis])

func ButtonPressed(button):
	button.emit_signal("pressed")
	setButtonPressed(button, true, true)

func setButtonPressed(button, toggle, pressed):
	button.set_toggle_mode(toggle)
	button.set_pressed(pressed)

func refreshVariablesIfSizeChange():
	pos_container = node_container.get_pos()
	pos_selector = node_selector.get_pos()
	size_container = node_container.get_size()
	
	selector_border_size = node_selector.get("custom_styles/panel").get_border_size()