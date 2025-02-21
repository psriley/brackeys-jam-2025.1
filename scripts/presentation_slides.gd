extends Sprite2D
var tmr_slides
var tmr_input
var slide_indicator
signal lose_life

@export var slides: Array[Texture] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.texture = slides[0]

	tmr_slides = $tmr_slides
	tmr_input = $tmr_input
	slide_indicator = $NextSlideIndicator
	
	#initialise values of timer and slide indicator
	tmr_slides.wait_time = 2.8
	slide_indicator.set_speed_scale(10)
	#Play slide animation and timer
	tmr_slides.start()
	slide_indicator.play("progress_bar")

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("spacebar_press") && tmr_input.time_left > 0.01:
		reset_timer()
		tmr_input.stop()

func _on_tmr_slides_timeout() -> void:
	tmr_input.start()
	slide_indicator.play("space_bar", 0)


func change_slide() -> bool:
	var new_slide = slides[randf_range(0,2)]

	while self.texture == new_slide:
		new_slide = slides[randf_range(0,2)]
	#
	if new_slide > 2:
		return false
		
	self.texture = new_slide
	return true

#Frames/(FPS*Speedscale) = time
#FPS set in the animation iteslf
func reset_timer() -> void:
	var good_slide_bool = change_slide()
	
	if good_slide_bool:
		var temp_SS = randf_range(3.0,10.0)
		tmr_slides.wait_time = (28/temp_SS)
		slide_indicator.set_speed_scale(temp_SS)
	else:
		var temp_SS = randf_range(10.0,14.0)
		tmr_slides.wait_time = (28/temp_SS)
		slide_indicator.set_speed_scale(temp_SS)
	
	tmr_slides.start()
	slide_indicator.play("progress_bar")


func _on_tmr_input_timeout() -> void:
	#Lose a life and resent the slides timer
	lose_life.emit()
	slide_indicator.set_speed_scale(1)
	slide_indicator.play("space_bar")
	await get_tree().create_timer(1.0).timeout
	reset_timer()
	pass # Replace with function body.
