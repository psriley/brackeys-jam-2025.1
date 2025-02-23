extends MiniGame
@onready var preload_input_box = preload("res://scenes/QuestionGame/InputTextbox.tscn")
var answers_sprites: Array
var input_box_instance: Control
var question_string: String
var answer_string: String

#var dict_questions = {
	#"What is the Capital of France":"Paris",
	#"What animal goes moo":["Cow", "Pig", "Dog"],
	#"How do our reports look?":"good, bad, really bad"
#}

func _ready() -> void:
	tmr_time = 2.5
	tmr_weight = get_parent().get_child(1).tmr_weight
	preload_answers()
	super._ready()
	m_type = MiniGameType.QUESTION
	
	initialise_inputbox()
	


func initialise_inputbox() -> void:
	input_box_instance = preload_input_box.instantiate()
	input_box_instance.input_event_end.connect(_question_end)
	input_box_instance.position = Vector2(50,50)
	input_box_instance.target_answer = answer_string
	get_parent().add_child(input_box_instance)

func preload_answers() -> void:
	var i = randi_range(0,1)
	match i:
		0:
			question_string = "What animal goes moo?"
			answer_string = "pig"
			answers_sprites = [preload("res://Assets/Sprites/answer_sprites/Answer Pig.png"), preload("res://Assets/Sprites/answer_sprites/answer_cow.png"), preload("res://Assets/Sprites/answer_sprites/answer_dog.png")]
		1:
			question_string = "How are our reports?"
			answer_string = "good"
			answers_sprites = [preload("res://Assets/Sprites/answer_sprites/answer_bad.png"), preload("res://Assets/Sprites/answer_sprites/answer_awful.png"), preload("res://Assets/Sprites/answer_sprites/answer_good.png")]

			pass
	pass

func set_answers() -> void:
	get_child(2).get_child(0).texture = answers_sprites[0].instantiate()
	get_child(3).get_child(0).texture = answers_sprites[1].instantiate()
	get_child(4).get_child(0).texture = answers_sprites[2].instantiate()
	pass
	
# Called when the node enters the scene tree for the first time.
func _set_text(temp_string: String ) -> void:
	$RichTextLabel.set_text(temp_string)
	pass # Replace with function body.
	
func _question_end(success_flag: bool) -> void:
	if success_flag:
		input_box_instance.queue_free()
		_game_success()
		self.queue_free()
	else:
		lose_life.emit()
		input_box_instance.queue_free()
		self.queue_free()
	
