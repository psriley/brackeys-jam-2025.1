extends MiniGame

var num_clicks : int
var tot_clicks : int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tmr_time = 2
	super._ready()
	num_clicks = randi_range(1, 6)
	print(num_clicks)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("mouse_click"):
		tot_clicks += tot_clicks
		
		if tot_clicks >= num_clicks:
			tmr_success.stop()
			_game_success()
			self.queue_free()
