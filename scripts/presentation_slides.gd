extends Sprite2D
var tmr_slides
var tmr_input
@export var slides: Array[Texture] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.texture = slides[0]

	tmr_slides = $tmr_slides
	tmr_input = $tmr_input
	tmr_slides.start()

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("spacebar_press") && tmr_input.time_left > 0.01:
		reset_timer()
		tmr_input.stop()
		print("Next Slide")

func _on_tmr_slides_timeout() -> void:
	tmr_input.start()
	print("Slide complete, awaiting input.")


func change_slide() -> void:
	var new_slide = slides[randf_range(0,3)]

	while self.texture == new_slide:
		new_slide = slides[randf_range(0,3)]
	self.texture = new_slide


func reset_timer() -> void:
	tmr_slides.wait_time = randf_range(2.0,4.0)

	#print ("Time to next timeout: " + str(timer.wait_time))
	#print("Texture number = " + str(i))
	change_slide()
	tmr_slides.start()


func _on_tmr_input_timeout() -> void:
	#Lose a life and resent the slides timer
	print("Failed to input in time! -1 life")
	reset_timer()
	pass # Replace with function body.
