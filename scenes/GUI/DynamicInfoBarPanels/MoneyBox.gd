
onready var game = get_node("/root/Game")
onready var player = game.scene.get_node("Player")
onready var box_container = get_node("./Money/HBoxContainer")

func _ready():
	splitMoney()

func splitMoney():
	var money = player.money
	var moneyArray = Array()
	
	while (money != 0):
		moneyArray.push_back(money%10)
		money = money/10
	
	if (moneyArray.size() > 7):
		return
	
	moneyArray = reverseArray(moneyArray)
	displayMoney(moneyArray)

func displayMoney(money_array):
	addEmptyLabels(7 - money_array.size())
	addMoneyNumber(money_array)

func addEmptyLabels(number_empty_label):
	var label = Label.new()
	box_container.add_child(label)
	
	for case in range ( number_empty_label ):
		label = createLabelForContainer(" ")
		
		box_container.add_child(label)
		box_container.add_child(VSeparator.new())

func addMoneyNumber(money_array):
	var label
	
	for case in range ( money_array.size() ):
		if ( case < money_array.size() ):
			label = createLabelForContainer(str(money_array[case]))
		else:
			label = createLabelForContainer(" ")
		
		box_container.add_child(label)
		
		if ( case + 1 != money_array.size()):
			box_container.add_child(VSeparator.new())
	
	label = Label.new()
	box_container.add_child(label)

func createLabelForContainer(text):
	var label = Label.new()
	label.set_align(label.ALIGN_CENTER)
	label.set_valign(label.VALIGN_CENTER)
	label.set_h_size_flags(label.SIZE_EXPAND_FILL)
	label.set_v_size_flags(label.SIZE_EXPAND_FILL)
	label.set_text(text)
	
	return label


func reverseArray(array):
	var new_array = Array()
	
	for position in range ( array.size() ):
		new_array.push_back(array[array.size() - (position+1)])
	
	return new_array
