extends LineEdit
@export var target_answer: String
signal input_event_end(correct_answer)
var correct_answer = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LineEdit.grab_focus()
	pass # Replace with function body.


func _on_line_edit_text_changed(new_text: String) -> void:
	if $LineEdit.text == target_answer:
		#Tell the manager that this is done.
		correct_answer = true
		input_event_end.emit(correct_answer)
		$".".queue_free()
	pass # Replace with function body.
