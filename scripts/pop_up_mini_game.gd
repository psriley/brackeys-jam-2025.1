extends MiniGame

var sfx_spawn : AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tmr_time = 2
	tmr_weight = get_parent().get_child(1).tmr_weight
	super._ready() # Ensure base class runs first	
	m_type = MiniGameType.POP_UP
	anger_bar = get_child(1)
	setup_anger_bar()
	sfx_spawn = get_child(2)
	sfx_spawn.play()
	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#event.pressed
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
	if Input.is_action_pressed("mouse_click"):
		tmr_success.stop()
		_game_success()
		self.queue_free()
