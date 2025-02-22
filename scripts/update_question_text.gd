extends MiniGame
@onready var preload_input_box = preload("res://scenes/QuestionGame/InputTextbox.tscn")
var input_box_instance: Control
var question_string: String
var answer_string: String

func _ready() -> void:
	tmr_time = 2.5
	super._ready()
	m_type = MiniGameType.QUESTION
	#Spawn an Input Textbox by adding it to parent as a sibling
	#link the signal "input_event_end"
	#when that signal is recieved emit the mini_game_base signal 
	input_box_instance = preload_input_box.instantiate()
	input_box_instance.input_event_end.connect(_question_end)
	input_box_instance.position = Vector2(50,50)
	input_box_instance.target_answer = answer_string
	
	get_parent().add_child(input_box_instance)
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
	
