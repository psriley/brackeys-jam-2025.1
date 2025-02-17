extends Sprite2D
var timer
@export var slides: Array[Texture] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.texture = slides[0]
	
	timer = self.get_child(0)
	timer.start()
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("spacebar_press"):
		reset_timer()

func _on_tmr_slides_timeout() -> void:
	reset_timer()

func change_slide() -> void:
	#self.texture = slides[randf_range(0,3)]
	var new_slide = slides[randf_range(0,3)]
	
	while self.texture == new_slide:
		new_slide = slides[randf_range(0,3)]
	self.texture = new_slide


func reset_timer() -> void:
	timer.wait_time = randf_range(2.0,4.0)
	#var i = randf_range(0,3)
	#i = int(i)
	#match i:
		#0:
			#timer.wait_time = 10.0
			#timer_window = 2.0
		#1:
			#
		#2:
	
	print ("Time to next timeout: " + str(timer.wait_time))
	#print("Texture number = " + str(i))
	change_slide()
	timer.start()
