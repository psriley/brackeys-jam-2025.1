extends MiniGame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tmr_time = 1.5
	super._ready() # Ensure base class runs first
	m_type = MiniGameType.POP_UP
	#lose_life.emit(m_type)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#event.pressed
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
	if Input.is_action_pressed("mouse_click"):
		self.queue_free()
	
