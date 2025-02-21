extends Area2D
class_name DroppableArea


var hovering_object : SwipeableObject
var held_object : SwipeableObject


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.modulate = Color(Color.MEDIUM_PURPLE, 0.7)


func _input(event: InputEvent) -> void:
	if hovering_object and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			set_drop_area()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# @param start_set: If setting a drop area on start (no hovering present)
func set_drop_area() -> void:
	self.modulate = Color(Color.MEDIUM_PURPLE, 0.7)
	
	if hovering_object.drop_area:
		remove_held_object()
	
	# set the position of the dropped object
	hovering_object.position = self.position
	hovering_object.drop_area = self
	held_object = hovering_object
	hovering_object = null
	get_parent().queue_free() # swipe done correctly
	#hovering_object.queue_free() 


func remove_held_object() -> void:
	hovering_object.drop_area.held_object = null


func _on_mouse_entered() -> void:
	#print("Mouse entered droppable area!")
	pass


func _on_mouse_exited() -> void:
	#print("Mouse exited droppable area!")
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("swipeable_objects"):
		var temp_swipe_object = area.get_parent() as SwipeableObject
		if temp_swipe_object.drop_area and temp_swipe_object.drop_area == self:
			# don't need to do anything if the drop area entered is already this drop area
			return
		
		self.modulate = Color(Color.REBECCA_PURPLE, 1)
		hovering_object = temp_swipe_object
		hovering_object.hovering_drop_area = true
		#print("Swipeable object in drop area!")


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("swipeable_objects"):
		self.modulate = Color(Color.MEDIUM_PURPLE, 0.7)
		if hovering_object: 
			hovering_object.hovering_drop_area = false
			hovering_object = null
		elif held_object:
			held_object.hovering_drop_area = false
		#print("Swipeable object left drop area!")
