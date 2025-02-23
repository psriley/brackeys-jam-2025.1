extends Control

@onready var start_text : Label = $Start
@onready var instructions_text : Label = $Instructions
@onready var quit_text : Label = $Quit

@onready var main_scene = preload("res://scenes/main.tscn")
@onready var instructions_scene = preload("res://scenes/instructions-menu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Mouse entered and exited signals
func _on_start_button_mouse_entered() -> void:
	start_text.add_theme_color_override("font_color", Color.WHITE)


func _on_start_button_mouse_exited() -> void:
	start_text.remove_theme_color_override("font_color")


func _on_instructions_button_mouse_entered() -> void:
	instructions_text.add_theme_color_override("font_color", Color.WHITE)


func _on_instructions_button_mouse_exited() -> void:
	instructions_text.remove_theme_color_override("font_color")


func _on_quit_button_mouse_entered() -> void:
	quit_text.add_theme_color_override("font_color", Color.WHITE)


func _on_quit_button_mouse_exited() -> void:
	quit_text.remove_theme_color_override("font_color")


# Button pressed signals
func _on_start_button_button_up() -> void:
	get_tree().change_scene_to_packed(main_scene)


func _on_instructions_button_button_up() -> void:
	get_tree().change_scene_to_packed(instructions_scene)


func _on_quit_button_button_up() -> void:
	get_tree().quit()
