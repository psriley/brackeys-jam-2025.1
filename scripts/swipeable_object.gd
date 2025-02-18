extends Node2D
class_name SwipeableObject


@onready var area_2d = $Area2D  # Get reference to Area2D
@export var drop_area : DroppableArea # DropArea that this object is currently in
@export var hovering_drop_area : bool = false
var swiping = false  # Tracks if the object is being swiped


func _ready() -> void:
	area_2d.add_to_group("swipeable_objects")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if swiping:
		var mousepos = get_viewport().get_mouse_position()
		self.position = Vector2(self.position.x, mousepos.y)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if swiping and event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			swiping = false
			#print("Mouse Left Button Up at ", event.position)
			
			if drop_area and drop_area.held_object and !hovering_drop_area:
				self.position = drop_area.position


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			swiping = true
			#print("Mouse Left Button Down at ", event.position)
