extends Control

@onready var title_menu = preload("res://scenes/title-menu.tscn")
@onready var next_arrow = $ForwardNavButton

var slide_images : Array[PackedScene] = [
	preload("res://scenes/InstructionScenes/instruction_1.tscn"), 
	preload("res://scenes/InstructionScenes/instruction_2.tscn"),
	preload("res://scenes/InstructionScenes/instruction_3.tscn"),
	preload("res://scenes/InstructionScenes/instruction_4.tscn"),
	preload("res://scenes/InstructionScenes/instruction_5.tscn"),
	preload("res://scenes/InstructionScenes/instruction_6.tscn")
]
var cur_slide : int = 0
var slide_image_root : Node2D = Node2D.new()
var cur_slide_instance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(slide_image_root)
	cur_slide_instance = slide_images[cur_slide].instantiate()
	slide_image_root.add_child(cur_slide_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/title-menu.tscn")


func _on_forward_nav_button_button_up() -> void:
	cur_slide = cur_slide + 1
	if (cur_slide + 1) == slide_images.size():
		next_arrow.queue_free()
	slide_image_root.remove_child(cur_slide_instance)
	cur_slide_instance = slide_images[cur_slide].instantiate()
	slide_image_root.add_child(cur_slide_instance)


#func _on_back_nav_button_button_up() -> void:
	##if cur_slide_instance:
		##slide_image_root.remove_child(cur_slide_instance)
	#pass # Replace with function body.
