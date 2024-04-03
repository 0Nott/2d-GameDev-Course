extends Area2D


var max_speed := 1200.0
var velocity := Vector2(0, 0)
var steering_factor := 3.0


func _process(delta: float) -> void:
	var direction := Vector2(0, 0)
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")

	if direction.length() > 1.0:
		direction = direction.normalized()

	var desired_velocity := max_speed * direction
	var steering := desired_velocity - velocity
	velocity += steering * steering_factor * delta
	position += velocity * delta

	if velocity.length() > 0.0:
		#rotation = velocity.angle()
		get_node("Sprite2D").rotation = velocity.angle()
		
var health := 10

func _ready()-> void:
	set_health(50)
	area_entered.connect(_on_area_entered)
	# This call updates the health bar to match the health variable when the
	# game starts.
	set_health(health)

func set_health(new_health: int) -> void:
	health = new_health
	get_node("UI/HealthBar").value = health
	
func _on_area_entered(area_that_entered: Area2D) -> void:
	set_health(health + 10)
	
