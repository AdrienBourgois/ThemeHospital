extends Panel

onready var gamescn = get_node("/root/Game").scene
onready var reputation_value = gamescn.player.reputation
onready var disease = gamescn.diseases
onready var diseases_list = disease.list_diseases

onready var hud = get_parent().get_node("HUD")
onready var node_reputation = get_node("Book/Informations/Reputation/values")
onready var node_container = get_node("Book/Buttons/ButtonsContainer")

onready var treatment_charge = 0

func _ready():
	connect()
	set_process(true)

func _on_Quit_pressed():
	self.hide()
	hud.show()

func update():
	node_reputation.set_text(str(reputation_value))

func _process(delta):
	update()

func connect():
	var button
	for disease in diseases_list:
		if (diseases_list[disease].FOUND == true):
			button = Button.new()
			node_container.add_child(button)
			
			button.set_text(diseases_list[disease].NAME)
#			buttons.connect("pressed", self, "disease_pressed",[type[rooms]])
			

func disease_pressed():
	pass
