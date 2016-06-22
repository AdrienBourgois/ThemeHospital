
extends Panel

onready var game = get_node("/root/Game")
onready var timer = get_node("Build_timer")
onready var progress_bar = get_node("ProgressBar")

func _ready():
	progress_bar.set_max(timer.get_wait_time())
	timer.connect("timeout", self, "_on_Build_timer_timeout")
	set_process(true)

func _process(delta):
	progress_bar.set_value(timer.get_time_left())

func _on_Build_timer_timeout():
	game.emit_signal("build_timer_timeout")
	game.scene.entity_manager.get_node("SpawnTimerPatient").start()
	self.queue_free()

func _on_Button_pressed():
	game.emit_signal("build_timer_timeout")
	game.scene.entity_manager.get_node("SpawnTimerPatient").start()
	self.queue_free()

func _on_Build_timer_panel_mouse_enter():
	game.feedback.display("TUTO_GO")
