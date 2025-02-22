extends Node
@onready var timer = $tmr_next_game
@onready var audience_positions : Node2D = $"../../AudiencePositions"

@export var health: int = 3
@export var audience : Array[Sprite2D] = []
#preload all minigames:
var pop_up_scenes = [preload("res://scenes/PopupGames/pop_up_mini_game1.tscn"), preload("res://scenes/PopupGames/pop_up_mini_game2.tscn"), preload("res://scenes/PopupGames/pop_up_mini_game3.tscn")]
var swipe_scene = preload("res://scenes/swipe_mini_game.tscn")
var question_input = preload("res://scenes/QuestionGame/InputTextbox.tscn")
var question_display = preload("res://scenes/QuestionGame/question_display.tscn")
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

var cur_minigame_instances : Array[MiniGame]

func _ready() -> void:
	minigames_arr = [0, 1] #TODO: Add question minigame back when it works with the minigame structure
	audience = [audience_positions.get_child(0), audience_positions.get_child(1), audience_positions.get_child(2)]
	if audience.size() != health:
		printerr("Health and audience size must be equal!")
		printerr("Health = " + str(health))
		printerr("Audience size = " + str(audience.size()))
		assert(audience.size() == health)


func _on_tmr_next_game_timeout() -> void:
	timer.wait_time = randf_range(2.0,6.0)
	_next_game()
	timer.start()


func minigame_failure(minigame_ref : MiniGame) -> void:
	health -= 1
	#remove audience member
	#minigame_ref.audience_member_upset.queue_free()
	var audience_int : int = audience.find(minigame_ref.audience_member_upset)
	audience.pop_at(audience_int)
	print("Health is now: " + str(health) + " because of " + MiniGame.MiniGameType.find_key(minigame_ref.m_type))


#Code to instantiate the next game
func _next_game() -> void:
	if audience.size() <= 0:
		print("Can't add a new game because health is 0 (game over)")
		return
		
	var add_slide_back : bool = false
	
	if is_instance_valid(swipe_instance):
		add_slide_back = true
		minigames_arr.pop_at(1)
	
	var i : int = minigames_arr.pick_random()
	#var i : int = 0
	
	var cur_minigame_instance : MiniGame = create_minigame_instance(i)
	cur_minigame_instances.append(cur_minigame_instance)
	
	cur_minigame_instance.audience_member_upset = audience[0]

	if add_slide_back:
		minigames_arr.insert(1, 1)



#func _on_question_input_end(player_answer):
	#if player_answer == false:
		##health -= 1
		#minigame_failure(MiniGame.MiniGameType.QUESTION)
		#pass
	#else:
		##Nothing?
		#pass
	#question_instance.queue_free()
	#
	#pass
	
	
func create_minigame_instance(m_type : int) -> MiniGame:
	match m_type:
		0:
			var popup_instance : MiniGame = pop_up_scenes.pick_random().instantiate()
			# connect base minigame signal to manager function
			popup_instance.lose_life.connect(minigame_failure)
			#popup_instance.audience_member_irritated = 
			
			#randomise position between defined boundaries
			#random range between 2 x co-ords and 2 y co-ords
			#Range limit: (24,19) (66,34)
			var temp_x = randi_range(24, 66)
			var temp_y = randi_range(19, 34)
			popup_instance.position = Vector2(temp_x,temp_y)

			get_parent().add_child(popup_instance)
			return popup_instance
			#load pop_up_scene
		1:
			swipe_instance = swipe_scene.instantiate()
			swipe_instance.lose_life.connect(minigame_failure)
			
			get_parent().add_child(swipe_instance)
			swipe_instance.position_offset = Vector2(57,15)
			swipe_instance.position = swipe_instance.position_offset
			
			return swipe_instance
			#load swipte_mini_game
		#2:
			#print("add question")
			#var x = randf_range(0, dict_questions.size())
			#var answer_instance : Control = question_input.instantiate()
			#question_instance = question_display.instantiate()
			#var temp_question: String
			#var temp_answer: String

			#match int(x):
				#0:
					#print(dict_questions.get("Paris"))
					#temp_question = dict_questions.get("Paris")
					#temp_answer = "Paris"
#
				#1:
					#temp_question = dict_questions.get("Cow")
					#temp_answer = "Cow"
#
			##set up input text box and question box with chosen question
			#answer_instance.target_answer = temp_answer
			#answer_instance.input_event_end.connect(_on_question_input_end)
			#answer_instance.position = Vector2(50,50)
#
			#question_instance._set_text(temp_question)
			#print("And the question is... " + temp_question)
			#question_instance.position = Vector2(50,100)
#
			##instantiate
			##get parent can be a direct reference instead
			#get_parent().add_child(answer_instance)
			#get_parent().add_child(question_instance)
			#
			#return MiniGame.new()
	
	printerr("Unknown MiniGame created (audience member not going to be attached correctly)!")
	return MiniGame.new()


func _on_spr_presentation_failed_slide() -> void:
	for i in cur_minigame_instances:
		i._slide_failed()
		
