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
	tmr_success.one_shot = true
	tmr_success.timeout.connect(_on_timer_timeout)
	add_child(tmr_success) # add created timer to scene tree so it works
	tmr_success.start()


func _on_timer_timeout() -> void:
	lose_life.emit(m_type)
