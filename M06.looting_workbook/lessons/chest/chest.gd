#extends Area2D
#@onready var canvas_group: CanvasGroup = $CanvasGroup
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	##pass # Replace with function body.
	#mouse_entered.connect(_on_mouse_entered)
	#mouse_entered.connect(_on_mouse_exited)
	#canvas_group.material.set_shader_parameter("line_thickness", 3.0)
	#
	#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#
#func _on_mouse_entered() -> void:
	#canvas_group.material.set_shader_parameter("line_thickness", 6.0)
	#var tween := create_tween()
	#tween.tween_method(set_outline_thickness, 3.0, 6.0, 0.08)
	#
#func _on_mouse_exited() -> void:
	#canvas_group.material.set_shader_parameter("line_thickness", 3.0)
	#var tween := create_tween()
	#tween.tween_method(set_outline_thickness, 6.0, 3.0, 0.08)
	#
#func set_outline_thickness(new_thickness: float) -> void:
	#canvas_group.material.set_shader_parameter("line_thickness", new_thickness)
	
	
extends Area2D
@onready var canvas_group: CanvasGroup = $CanvasGroup

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	canvas_group.material.set_shader_parameter("line_thickness", 3.0)

func set_outline_thickness(new_thickness: float) -> void:
	canvas_group.material.set_shader_parameter("line_thickness", new_thickness)

func _on_mouse_entered() -> void:
	var tween := create_tween()
	tween.tween_method(set_outline_thickness, 3.0, 6.0, 0.08)

func _on_mouse_exited() -> void:
	var tween := create_tween()
	tween.tween_method(set_outline_thickness, 6.0, 3.0, 0.08)
	
func _input_event(viewport: Node, event: InputEvent, shape_index: int):
	var event_is_mouse_click: bool = (
		event is InputEventMouseButton and
		event.button_index == MOUSE_BUTTON_LEFT and
		event.is_pressed()
	)

	if event_is_mouse_click:
		open()
		
var is_open := false
		
@onready var animation_player: AnimationPlayer = $AnimationPlayer
func open() -> void:
	if is_open:
		return
		
	is_open = true
	
	if animation_player.assigned_animation == "open":
		return
		
	input_pickable = false
	animation_player.play("open")
	
	for current_index in range(randi_range(1, 3)):
		_spawn_random_item()
		
@export var possible_item: Array[PackedScene] = []

func _spawn_random_item() -> void:
	var loot_item: Area2D = possible_item.pick_random().instantiate
	add_child(loot_item)
	var random_angle := randf_range(0.0, 2.0 * PI)
	var random_direction := Vector2(1.0, 0.0).rotated(random_angle)
	var random_distance := randf_range(60.0, 120.0)
	var land_position := random_direction * random_distance
	const FLIGHT_TIME := 0.4
	const HALF_FLIGHT_TIME := FLIGHT_TIME / 2.0

	var tween := create_tween()
	tween.set_parallel()
	loot_item.scale = Vector2(0.25, 0.25)
	tween.tween_property(loot_item, "scale", Vector2(1.0, 1.0), HALF_FLIGHT_TIME)
	tween.tween_property(loot_item, "position:x", land_position.x, FLIGHT_TIME)
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	
	var jump_height := randf_range(30.0, 80.0)
	tween.tween_property(loot_item, "position:y", land_position.y - jump_height, HALF_FLIGHT_TIME)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(loot_item, "position:y", land_position.y, HALF_FLIGHT_TIME)
