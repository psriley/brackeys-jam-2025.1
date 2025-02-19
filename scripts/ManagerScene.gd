extends Node
@onready var timer = $tmr_next_game
@export var health: int = 10
#preload all minigames:
var pop_up_scene = preload("res://scenes/pop_up_mini_game.tscn")
var swipe_scene = preload("res://scenes/swipe_mini_game.tscn")
var question_input = preload("res://scenes/InputTextbox.tscn")
var question_display = preload("res://scenes/question_display.tscn")
#Dict of questions and answers
#	Rule; Questions must be ~<30 Chars
var dict_questions = {
	"What is the Capital of France":"Paris",
	"How many goals in a hatrick":"three",
	"":""
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#Code to instanciate the next game
func _next_game() -> void:
	var i = randf_range(0.0,2.0)
	print("i is " + str(i))
	match int(i):
		0:
			var popup_instance : Node2D = pop_up_scene.instantiate()
			#randomise position between defined boundaries
			popup_instance.position = Vector2(225,225)
			popup_instance.scale = Vector2(0.55,0.55)
			
			get_parent().add_child(popup_instance)
			print("add pop up")
			#load pop_up_scene
		1:
			var swipe_instance : Node2D = swipe_scene.instantiate()
			get_parent().add_child(swipe_instance)
			print("add swipe game")
			#load swipte_mini_game
		2:
			var answer_instance : Control = question_input.instantiate()
			#retrieve answer from dict.
			answer_instance.target_answer = "Temp"
			answer_instance.input_event_end.connect(_on_question_input_end)
	pass

func _on_tmr_next_game_timeout() -> void:
	print("time's up!")
	timer.wait_time = randf_range(2.0,6.0)
	_next_game()
	timer.start()
	pass # Replace with function body.
	
func _on_question_input_end(correct_answer):
	if correct_answer == false:
		#health - 1
		pass
	#Kill Question popup
	pass
