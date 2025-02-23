extends Node2D

@onready var restart_button : Area2D = $RestartButton
@onready var restart_button_sprite : Sprite2D = $RestartButton/Restart
@onready var quit_button_sprite : Sprite2D = $QuitButton/Quit

@onready var score_label : Label = $ScoreLabel

@onready var restart_empty_texture = preload("res://Assets/Sprites/MenuSprites/restart-button-empty.png")
@onready var restart_filled_texture = preload("res://Assets/Sprites/MenuSprites/restart-button-filled.png")

@onready var quit_empty_texture = preload("res://Assets/Sprites/MenuSprites/quit-button-empty.png")
@onready var quit_filled_texture = preload("res://Assets/Sprites/MenuSprites/quit-button-filled.png")

var score : float = 0.0


func _ready() -> void:
	score_label.text = "Score: " + str(snapped(score, 0.01)) + " seconds!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_button_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("mouse_click"):
		# restart game
		get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_restart_button_mouse_entered() -> void:
	restart_button_sprite.texture = restart_filled_texture


func _on_restart_button_mouse_exited() -> void:
	restart_button_sprite.texture = restart_empty_texture


func _on_quit_button_mouse_entered() -> void:
	quit_button_sprite.texture = quit_filled_texture


func _on_quit_button_mouse_exited() -> void:
	quit_button_sprite.texture = quit_empty_texture


func _on_quit_button_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("mouse_click"):
		# quit game
		get_tree().quit()
