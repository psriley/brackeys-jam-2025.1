extends Node2D
class_name MiniGame

enum MiniGameType {POP_UP, SWIPE, QUESTION, INVALID = -1}

var tmr_success : Timer
var tmr_time : float
#Punishment timer increase
var tmr_weight: float

signal lose_life(minigame_type : MiniGameType)
var m_type : MiniGameType
var audience_member_upset
var audience_bar
var position_offset



func _ready() -> void:
	tmr_success = Timer.new()
	tmr_success.wait_time = tmr_time * tmr_weight

	tmr_success.one_shot = true
	tmr_success.timeout.connect(_on_timer_timeout)
	add_child(tmr_success) # add created timer to scene tree so it works
	

func _slide_failed() -> void:
	var new_time = (tmr_success.time_left-(tmr_success.time_left/10))
	tmr_success.stop()
	if new_time < 0.1:
		tmr_success.stop()
		_on_timer_timeout()
	else:
		tmr_success.wait_time = new_time
		tmr_success.start()

func _setup_audience_bar() -> void:
	audience_bar = audience_member_upset.get_child(0)
	audience_bar.set_speed_scale(28/tmr_success.wait_time)
	audience_bar.visible = true
	audience_bar.play("progress_bar")

#frame/time = speed
#speed*time = frame
func _update_audience_bar(time_remaining: float) -> void:
	audience_bar.pause()
	#var current_frame = 29 - audience_bar.frame 
	#audience_bar.set_speed_scale(current_frame/time_remaining)
	audience_bar.frame = 28 - (time_remaining*audience_bar.speed_scale)
	pass

func _on_timer_timeout() -> void:
	lose_life.emit(self)
	
	audience_member_upset.queue_free()
	#Play X animation(?)	
	self.queue_free()
	
func _game_success() -> void:
	if(audience_bar):
		audience_bar.stop()
		audience_bar.visible = false
	if audience_member_upset:
		get_parent().get_child(1).audience.append(audience_member_upset)
