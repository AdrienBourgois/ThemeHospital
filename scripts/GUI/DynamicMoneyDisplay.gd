
onready var game = get_node("/root/Game")
onready var player = game.scene.get_node("Player")
var last_money = 0

func _ready():
	set_process(true)

func _process( delta ):
	checkPlayerMoney()

func checkPlayerMoney():
	if ( last_money != player.money ):
		updateMoney()

func updateMoney():
	splitMoney()

func splitMoney():
	var money = int(player.money)
	last_money = money
	var money_array = Array()
	var is_money_negative = false
	
	if (money == 0):
		money_array.push_back(0)
	else:
		if (money < 0):
			is_money_negative = true
			money *= -1
		
		while (money != 0):
			money_array.push_back(money%10)
			money = money/10
	
	if (money_array.size() > 7):
		return
	
	if (is_money_negative):
		money_array[money_array.size()-1] *= -1
	
	displayMoney(money_array)

func displayMoney(money_array):
	for case in range ( money_array.size() ):
		if ( case < money_array.size() ):
			for item in range ( get_child_count() ):
				if (get_child( item ).get_name() == "Label_" + str( case )):
					get_child( item ).set_text(str(money_array[case]))
	
	for case in range (money_array.size(), 7):
			for item in range ( get_child_count() ):
				if (get_child( item ).get_name() == "Label_" + str( case )):
					get_child(item).set_text(" ")