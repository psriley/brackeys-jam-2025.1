extends Node2D
class_name MiniGame

enum MiniGameType {POP_UP, SWIPE, QUESTION, INVALID = -1}

var tmr_success : Timer
var tmr_time : float

signal lose_life(minigame_type : MiniGameType)
var m_type : MiniGameType
var audience_member_upset
var audience_bar
var position_offset


func _ready() -> void:
	tmr_success = Timer.new()
	tmr_success.wait_time = tmr_time

	tmr_success.one_shot = true
	tmr_success.timeout.connect(_on_timer_timeout)
	add_child(tmr_success) # add created timer to scene tree so it works
	

func _slide_failed() -> void:
	pass
	#var new_time = (tmr_success.time_left-(tmr_success.time_left/10))
	#tmr_success.stop()
	#if new_time < 0.1:
		#tmr_success.stop()
		#_on_timer_timeout()
	#else:
		#tmr_success.wait_time = new_time
		#tmr_success.start()

func _setup_audience_bar() -> void:
	audience_bar = audience_member_upset.get_child(0)
	audience_bar.set_speed_scale(28/tmr_success.wait_time)
	audience_bar.visible = true
	audience_bar.play("progress_bar")

func _on_timer_timeout() -> void:
	lose_life.emit(self)
	
	audience_member_upset.queue_free()
	#Play X animation(?)	
	self.queue_free()
