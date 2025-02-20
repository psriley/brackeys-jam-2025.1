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
	"Paris":"What is the Capital of France",
	"Cow":"What animal goes moo",
	"":""
}
#Empty node for minigames:
var question_instance : Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#Code to instanciate the next game
func _next_game() -> void:
	#var i = randf_range(0.0,2.0)
	var i = 2
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
			var x = randf_range(0, dict_questions.size())
			var answer_instance : Control = question_input.instantiate()
			question_instance = question_display.instantiate()
			var temp_question: String
			var temp_answer: String
			
			#Choose a random question
			#Hack-ey way of doing this but hey, it works.
			match int(x):
				0:
					print(dict_questions.get("Paris"))
					temp_question = dict_questions.get("Paris")
					temp_answer = "Paris"

				1:
					temp_question = dict_questions.get("Cow")
					temp_answer = "Cow"

			#set up input text box and question box with chosen question
			answer_instance.target_answer = temp_answer
			answer_instance.input_event_end.connect(_on_question_input_end)
			answer_instance.position = Vector2(50,50)
			
			question_instance._set_text(temp_question)
			print("And the question is... " + temp_question)
			question_instance.position = Vector2(50,100)
			
			#instantiate
			#get parent can be a direct reference instead
			get_parent().add_child(answer_instance)
			get_parent().add_child(question_instance)	
	pass

func _on_tmr_next_game_timeout() -> void:
	print("time's up!")
	timer.wait_time = randf_range(2.0,6.0)
	_next_game()
	timer.start()
	pass # Replace with function body.
	
func _on_question_input_end(player_answer):
	if player_answer == false:
		#health -= 1
		pass
	else:
		#Nothing?
		pass
	question_instance.queue_free()
	
	pass
