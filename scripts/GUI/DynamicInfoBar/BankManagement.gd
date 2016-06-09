
extends Control

onready var game = get_node("/root/Game")
onready var player = game.scene.player
onready var loan_manager = get_node("./Panel/LoanManager")
onready var hospital_value_line_edit = loan_manager.get_node("HospitalValueLineEdit")
onready var balance_line_edit = loan_manager.get_node("BalanceLineEdit")
onready var current_loan_line_edit = loan_manager.get_node("CurrentLoanLineEdit")
onready var interest_payment_line_edit = loan_manager.get_node("InterestPaymentLineEdit")

export var interest_rate = 0.4
export var maximum_loan = 20000
export var loan_step = 5000

var current_loan = 0
var current_interest = 0
var player_money = 0
var hospital_value = 0

func _ready():
	initializeVar()
	set_process(true)

func _process(delta):
	if ( player_money != player.money ):
		player_money = player.money
		balance_line_edit.set_text( str(player_money) )
	
	if ( hospital_value != player.hospital_value ):
		hospital_value = player.hospital_value
		hospital_value_line_edit.set_text( str(hospital_value) )


func initializeVar():
	current_loan = player.getLoan()
	player_money = player.getMoney()
	current_interest = player.getInterest()
	hospital_value = player.getHospitalValue()
	
	hospital_value_line_edit.set_text( str(hospital_value) )
	balance_line_edit.set_text( str(player_money) )
	current_loan_line_edit.set_text( str(current_loan) )
	calculateInterestPayment()

func calculateInterestPayment():
	current_interest = int( (interest_rate * current_loan)/100 )
	player.loan_interest = current_interest
	
	interest_payment_line_edit.set_text( str(current_interest) )

func _on_RepayLoanButton_pressed():
	if ( current_loan > 0 && player_money >= loan_step):
		current_loan -= loan_step
		current_loan_line_edit.set_text( str(current_loan) )
		player.money = player_money - loan_step
		player.setLoan(current_loan)
		
		calculateInterestPayment()


func _on_BorrowButton_pressed():
	if ( current_loan + loan_step <= maximum_loan ):
		current_loan += loan_step
		current_loan_line_edit.set_text( str(current_loan) )
		player.money = player_money + loan_step
		player.setLoan(current_loan)
		
		calculateInterestPayment()


func _on_QuitButton_pressed():
	set_process(false)
	queue_free()
