extends Node2D

@onready var restart_button : Area2D = $RestartButton
@onready var button_sprite : Sprite2D = $RestartButton/Restart
@onready var score_label : Label = $ScoreLabel

@onready var empty_texture = preload("res://Assets/Sprites/MenuSprites/restart-button-empty.png")
@onready var filled_texture = preload("res://Assets/Sprites/MenuSprites/restart-button-filled.png")

var score : float = 0.0


func _ready() -> void:
	score_label.text = "Score: " + str(snapped(score, 0.01)) + " seconds!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_button_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("mouse_click"):
		# restart game
		print("Restart Game")
		print("Score: " + str(score))
		pass


func _on_restart_button_mouse_entered() -> void:
	button_sprite.texture = filled_texture


func _on_restart_button_mouse_exited() -> void:
	button_sprite.texture = empty_texture
