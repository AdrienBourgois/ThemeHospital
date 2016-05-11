extends Timer

onready var game = get_node("/root/Game")
onready var stats = {}

export var day_duration = 3.0
export var day = 1 setget ,getDay
export(int, "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December") var month = 0 setget ,getMonth
var end_month
export var year = 1997 setget , getYear

var month_list = [tr("TXT_JANUARY"), 
				  tr("TXT_FEBRUARY"), 
				  tr("TXT_MARCH"), 
				  tr("TXT_APRIL"), 
				  tr("TXT_MAY"), 
				  tr("TXT_JUNE"), 
				  tr("TXT_JULY"), 
				  tr("TXT_AUGUST"), 
				  tr("TXT_SEPTEMBER"), 
				  tr("TXT_OCTOBER"), 
				  tr("TXT_NOVEMBER"), 
				  tr("TXT_DECEMBER")]

var thirty_days_month = ["April", "June", "September", "November"]

func _ready():
	checkThirtyDaysMonth()
	set_wait_time(day_duration/game.speed)
	game.connect("speed_change", self, "_on_Global_speed_change")

func test():
	print("TAMERE : ", game.scene.player)

func loadData():
	day = stats.DAY
	month = stats.MONTH
	year = stats.YEAR
	resetStatsDict()

func createStatsDict():
	stats = {
	DAY = getDay(),
	MONTH = getMonth(),
	YEAR = getYear(),
	}
	return stats

func resetStatsDict():
	stats.clear()

func _on_Global_speed_change():
	if game.speed > 0:
		set_wait_time(day_duration/game.speed)
		start()

func _on_Calendar_timeout():
	day += 1
	
	checkEndMonth() 

func checkEndMonth():
	if day > end_month:
		day = 1
		month += 1
		game.emit_signal("end_month")
		checkEndYear()
		checkThirtyDaysMonth()

func checkEndYear():
	if month > 11:
		month = 0
		year += 1 

func checkThirtyDaysMonth():
	var actual_month = month_list[month]
	
	if actual_month == "February":
		checkFebruaryDays()
		return
	
	for idx in thirty_days_month:
		if actual_month == idx :
			end_month = 30
			return
	
	end_month = 31

func checkFebruaryDays():
	if decimals(year/4.0) == 0:
		end_month = 29
	else:
		end_month = 28

func getDay():
	return day

func getMonth():
	return month

func getMonthInList():
	return month_list[month]

func getYear():
	return year