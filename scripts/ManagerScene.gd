extends Node
@onready var timer = $tmr_next_game

@export var health: int = 6
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
var swipe_instance : Node2D

var num_minigames : int = 3
var minigames_arr : Array[int]

func _ready() -> void:
	minigames_arr = [0, 1, 2]

func _on_tmr_next_game_timeout() -> void:
	print("time's up!")
	timer.wait_time = randf_range(2.0,6.0)
	_next_game()
	timer.start()


func minigame_failure(minigame_type) -> void:
	health -= 1
	#remove audience member
	print("Health is now: " + str(health))
	print(MiniGame.MiniGameType.find_key(minigame_type))


#Code to instantiate the next game
func _next_game() -> void:
	if swipe_instance:
		minigames_arr.pop_at(1)
	
	var i = minigames_arr.pick_random()
	print("i is " + str(i))
	match int(i):
		0:
			var popup_instance : MiniGame = pop_up_scene.instantiate()
			# connect base minigame signal to manager function
			popup_instance.lose_life.connect(minigame_failure)
			#popup_instance.audience_member_irritated = 
			
			#randomise position between defined boundaries
			#random range between 2 x co-ords and 2 y co-ords
			popup_instance.position = Vector2(25,25)

			get_parent().add_child(popup_instance)
			print("add pop up")
			#load pop_up_scene
		1:
			swipe_instance = swipe_scene.instantiate()
			swipe_instance.lose_life.connect(minigame_failure)
			
			get_parent().add_child(swipe_instance)
			swipe_instance.position_offset = Vector2(57,15)
			swipe_instance.position = swipe_instance.position_offset
			print("add swipe game")
			#load swipte_mini_game
		2:
			print("add question")
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
		
	if swipe_instance:
		minigames_arr.insert(1, 1)



func _on_question_input_end(player_answer):
	if player_answer == false:
		#health -= 1
		minigame_failure(MiniGame.MiniGameType.QUESTION)
		pass
	else:
		#Nothing?
		pass
	question_instance.queue_free()
	
	pass
