extends Node2D
var item_scenes := [
	preload("res://lessons/Gem.tscn"),
	preload("res://lessons/health_pack.tscn")
]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#var gem_scene := preload("res://lessons/Gem.tscn")
	#var gem_instance := gem_scene.instantiate()
	#add_child(gem_instance)
	get_node("Timer").timeout.connect(_on_timer_timeout)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
		#pass # Replace with function body.
	var random_item_scene: PackedScene = item_scenes.pick_random()
	var item_instance := random_item_scene.instantiate()
	
	var viewport_size := get_viewport_rect().size
	var random_position := Vector2(0, 0)
	random_position.x = randf_range(0, viewport_size.x)
	random_position.y = randf_range(0, viewport_size.y)
	item_instance.position = random_position
	add_child(item_instance)
