extends Node
@onready var timer = $tmr_next_game
var pop_up_scene = preload("res://scenes/pop_up_mini_game.tscn")
var swipe_scene = preload("res://scenes/swipe_mini_game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#Code to instanciate the next game
func _next_game() -> void:
	var i = 0#randf_range(0.0,2.0)
	print("i is " + str(i))
	match int(i):
		0:
			var popup_instance : Node2D = pop_up_scene.instantiate()
			#randomis position between defined boundaries
			popup_instance.position = Vector2(225,225)
			popup_instance.scale = Vector2(0.55,0.55)
			
			get_parent().add_child(popup_instance)
			print("add pop up")
			#load pop_up_scene
		1:
			get_parent().add_child(swipe_scene.instantiate())
			print("add swipe game")
			#load swipte_mini_game
	pass

func _on_tmr_next_game_timeout() -> void:
	print("time's up!")
	timer.wait_time = randf_range(2.0,6.0)
	_next_game()
	timer.start()
	pass # Replace with function body.
