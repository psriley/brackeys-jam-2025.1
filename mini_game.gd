extends Node2D
class_name MiniGame

enum MiniGameType {POP_UP, SWIPE, QUESTION, INVALID = -1}

var tmr_success : Timer
var tmr_time : float

signal lose_life(minigame_type : MiniGameType)
var m_type : MiniGameType
var audience_member_upset
var position_offset


func _ready() -> void:
	tmr_success = Timer.new()
	tmr_success.wait_time = tmr_time
	#var 10%_time float
	tmr_success.one_shot = true
	tmr_success.timeout.connect(_on_timer_timeout)
	add_child(tmr_success) # add created timer to scene tree so it works
	tmr_success.start()

#function slide failed
#	timer.get time remaining
#	tmr. stop
#	var new_time = time_left - 10%
#	tmr wait time = time left - 10%
#	if new_time < 0.1s
#		tmr.stop()
#		_on_timer_timeout()
#	elif newtime > 0.1s
#		
#	evaluate if timer left is negative, if so activate mini_end 
#	tmr start

func _slide_failed() -> void:
	var new_time = (tmr_success.time_left-(tmr_success.time_left/10))
	tmr_success.stop()
	if new_time < 0.1:
		tmr_success.stop()
		_on_timer_timeout()
	else:
		#Adjust remaining annoyance bars
		pass

func _on_timer_timeout() -> void:
	lose_life.emit(self)
	#Play X animation(?)
	audience_member_upset.queue_free()
	self.queue_free()
