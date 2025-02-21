extends Node2D
class_name MiniGame

enum MiniGameType {POP_UP, SWIPE, QUESTION, INVALID = -1}

signal lose_life(minigame_type : MiniGameType)
var m_type : MiniGameType
var audience_member_irritated

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
