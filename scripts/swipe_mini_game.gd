extends MiniGame

@onready var swipeable_object : SwipeableObject = $SwipeableObject
@onready var end_swipe_area = $EndSwipeArea

var sfx_spawn : AudioStreamPlayer

var swipeable_sprite : Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	m_type = MiniGameType.SWIPE
	tmr_time = 3.0
	tmr_weight = get_parent().get_child(1).tmr_weight
	super._ready()
	#lose_life.emit(m_type)
	swipeable_sprite = swipeable_object.get_child(0)
	anger_bar = get_child(1).get_child(2)
	setup_anger_bar()
	sfx_spawn = get_child(2)
	sfx_spawn.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var distance = swipeable_object.global_position.distance_to(end_swipe_area.global_position)
	#var clamped_distance = clamp(distance, 0, 1)
	#print(clamped_distance)
	#swipeable_sprite.modulate.a = clamped_distance
	pass
