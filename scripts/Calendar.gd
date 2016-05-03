extends Timer

onready var game = get_node("/root/Game")
onready var gui = game.scene.get_node("In_game_gui/Control_panel/Calendar")

export var day_duration = 3.0
export var day = 1 setget ,get_day
export(int, "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December") var month = 0 setget ,get_month
var end_month
export var year = 1997 setget , get_year

var month_list = ["January", 
				  "February", 
				  "March", 
				  "April", 
				  "May", 
				  "June", 
				  "July", 
				  "August", 
				  "September", 
				  "October", 
				  "November", 
				  "December"]

var thirty_days_month = ["April", "June", "September", "November"]

func _ready():
	check_thirty_days_month()
	set_wait_time(day_duration/game.speed)
	game.connect("speed_change", self, "_on_Global_speed_change")

func _on_Global_speed_change():
	if game.speed > 0:
		set_wait_time(day_duration/game.speed)
		start()

func _on_Calendar_timeout():
	day += 1
	
	check_end_month() 

func check_end_month():
	if day > end_month:
		day = 1
		month += 1
		game.emit_signal("end_month")
		check_end_year()
		check_thirty_days_month()

func check_end_year():
	if month > 11:
		month = 0
		year += 1 

func check_thirty_days_month():
	var actual_month = month_list[month]
	
	if actual_month == "February":
		check_february_days()
		return
	
	for idx in thirty_days_month:
		if actual_month == idx :
			end_month = 30
			return
	
	end_month = 31

func check_february_days():
	if decimals(year/4.0) == 0:
		end_month = 29
	else:
		end_month = 28

func get_day():
	return day

func get_month():
	return month_list[month]

func get_year():
	return year