extends Node2D

var is_swiping = false


#signal swipe
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#self.swipe.connect(_set_swiping)
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#var y_mousepos: float = 0.0
	#
	#if swiping:
		#y_mousepos = get_viewport().get_camera_2d().get_screen_to_world(get_viewport().get_mouse_position())
		#self.global_position = Vector2(self.position.x, y_mousepos)
#
#
#func _set_swiping():
	#swiping = !swiping
#
#
#func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#emit_signal("swipe")
		#elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			#emit_signal("swipe")
