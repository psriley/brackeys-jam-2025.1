extends LineEdit
@export var target_answer: String
signal input_event_end(correct_answer)
var correct_answer = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LineEdit.grab_focus()
	pass # Replace with function body.


func _on_line_edit_text_changed(new_text: String) -> void:
	if $LineEdit.text.to_lower() == target_answer.to_lower():
		#Tell the manager that this is done.
		correct_answer = true
		input_event_end.emit(correct_answer)
		$".".queue_free()

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("enter_press"):
		correct_answer = false
		input_event_end.emit(correct_answer)
		$".".queue_free()
