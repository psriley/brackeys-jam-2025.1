extends Node2D


@export var dragging : bool = false

signal drag


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_drag() -> void:
	dragging = true
	print("Dragging is set to true")
