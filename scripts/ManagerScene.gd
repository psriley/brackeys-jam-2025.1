extends Node
var time_score : float = 0.0
var game_active : bool = false

@onready var timer = $tmr_next_game
@onready var audience_positions : Node2D = $"../../AudiencePositions"
@onready var presentation = $"../../spr_presentation"

@export var health: int = 3
@export var tmr_weight: float = 1
@export var audience : Array[Sprite2D] = []
#preload all minigames:
var pop_up_scenes = [preload("res://scenes/PopupGames/pop_up_mini_game1.tscn"), preload("res://scenes/PopupGames/pop_up_mini_game2.tscn"), preload("res://scenes/PopupGames/pop_up_mini_game3.tscn")]
var swipe_scene = preload("res://scenes/swipe_mini_game.tscn")
var laptop_scene = preload("res://scenes/laptop_area.tscn")
var question_input = preload("res://scenes/QuestionGame/InputTextbox.tscn")
var question_display = preload("res://scenes/QuestionGame/question_display.tscn")
var game_over = preload("res://scenes/game_over.tscn")
#Dict of questions and answers
#	Rule; Questions must be ~<30 Chars
var dict_questions = {
	"What is the Capital of France":"Paris",
	"What animal goes moo":["Cow", "Pig", "Dog"],
	"":""
}
#Empty node for minigames:
var question_instance : Node2D
var swipe_instance : Node2D
var laptop_instance : Node2D

#var num_minigames : int = 3
var minigames_arr : Array[int]

var cur_minigame_instances : Array[MiniGame]

func _ready() -> void:
	game_active = true
	minigames_arr = [0, 1, 2, 3] #TODO: Add question minigame back when it works with the minigame structure
	audience = [audience_positions.get_child(0), audience_positions.get_child(1), audience_positions.get_child(2)]
	if audience.size() != health:
		printerr("Health and audience size must be equal!")
		printerr("Health = " + str(health))
		printerr("Audience size = " + str(audience.size()))
		assert(audience.size() == health)


func _process(delta: float) -> void:
	if game_active:
		time_score += delta


func _on_tmr_next_game_timeout() -> void:
	timer.wait_time = randf_range(0.5,3.0)
	_next_game()
	timer.start() 


func minigame_failure(minigame_ref : MiniGame) -> void:
	health -= 1
	#remove audience member
	#minigame_ref.audience_member_upset.queue_free()
	#audience.pick_random().queue_free()
	audience[0].queue_free()
	audience.pop_at(0)
	var minigame_int: int = cur_minigame_instances.find(minigame_ref)
	cur_minigame_instances.pop_at(minigame_int)
	
	print("Health is now: " + str(health) + " because of " + MiniGame.MiniGameType.find_key(minigame_ref.m_type))
	
	# Check if game is over, if so stop game and add game over screen
	if audience.is_empty():
		game_active = false
		presentation.queue_free()
		timer.queue_free()
		var game_over_screen : Node2D = game_over.instantiate()
		game_over_screen.position = Vector2(45.1, 26)
		game_over_screen.score = time_score
		get_parent().add_child(game_over_screen)
		
		# this is kind of messy, but all successful minigames become null in cur_minigame_instances...so we only want to remove the active ones here
		var non_null_minigame_instances = cur_minigame_instances.filter(func(x): return x != null)
		
		for minigame in non_null_minigame_instances:
			minigame.queue_free()


#Code to instantiate the next game
func _next_game() -> void:
	if audience.size() <= 0:
		print("Can't add a new game because health is 0 (game over)")
		return
	
	var slides_to_add_back : Array[int]
	#var add_slide_back : bool = false
	
	if is_instance_valid(swipe_instance):
		slides_to_add_back.append(swipe_instance.m_type)
		minigames_arr.pop_at(swipe_instance.m_type)
		
	if is_instance_valid(laptop_instance):
		slides_to_add_back.append(laptop_instance.m_type)
		minigames_arr.pop_at(laptop_instance.m_type)
		
	if is_instance_valid(question_instance):
		slides_to_add_back.append(question_instance.m_type)
		minigames_arr.pop_at(question_instance.m_type)
	
	# pick random number from large range to make ads more probable, and last minigames less probable
	# 60% chance for ad pop-up, 30% chance for swipe, 5% for laptop and question
	var rand_num = randi_range(1, 100)

	var i = 0

	if rand_num > 60 and rand_num <= 90 and minigames_arr.find(1) != -1:
		i = 1
	elif rand_num > 90 and rand_num <= 95 and minigames_arr.find(2) != -1:
		i = 2
	elif rand_num > 95 and rand_num <= 100 and minigames_arr.find(3) != -1:
		i = 3
		
	
	#var i : int = minigames_arr.pick_random()
	#var i : int = 2
	
	var cur_minigame_instance : MiniGame = create_minigame_instance(i)
	cur_minigame_instances.append(cur_minigame_instance)
	#############################
	#if(is_instance_valid(audience[0])):
		#cur_minigame_instance.audience_member_upset = audience[0]
		#audience.pop_at(0)
	#else:
		#printerr("Audience not valid, can't spawn game")
	#cur_minigame_instance._setup_audience_bar()
	###################################
	cur_minigame_instance.tmr_success.start()

	if !slides_to_add_back.is_empty():
		for slide_id in slides_to_add_back:
			minigames_arr.insert(slide_id, slide_id)  # Insert the slide back
			
		slides_to_add_back.clear() # This is probably not necessary since this is a local variable that gets recreated next frame

	#if !slides_to_add_back.is_empty():
		#for slide_id in slides_to_add_back.size():
			#minigames_arr.insert(slides_to_add_back[slide_id], slides_to_add_back[slide_id])
			#slides_to_add_back.pop_at(slide_id)
			
		#for slide in range(slides_to_add_back.size()):
			#slides_to_add_back[slide_id]
			#minigames_arr.insert(slide_id, slide_id)



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
		2: 
			laptop_instance = laptop_scene.instantiate()
			laptop_instance.lose_life.connect(minigame_failure)
			
			get_parent().add_child(laptop_instance)
			laptop_instance.position = Vector2(110,35)
			
			return laptop_instance
		3:
			#var x = randf_range(0, dict_questions.size())
			#var answer_instance : Control = question_input.instantiate()
			question_instance = question_display.instantiate()
			#print("And the question is... " + temp_question)
			#question_instance.position = Vector2(50,160)
			question_instance.global_position = Vector2(18,51)
			question_instance.scale = Vector2(0.083,0.083)

			#instantiate
			get_parent().add_child(question_instance)
			# grab focus on line edit
			return question_instance
	
	printerr("Unknown MiniGame created (audience member not going to be attached correctly)!")
	return MiniGame.new()


func _on_spr_presentation_failed_slide() -> void:
	if tmr_weight > 0.4:
		tmr_weight -= 0.1
	#for i in cur_minigame_instances:
		#if(is_instance_valid(i)):
			#i._slide_failed()
		
