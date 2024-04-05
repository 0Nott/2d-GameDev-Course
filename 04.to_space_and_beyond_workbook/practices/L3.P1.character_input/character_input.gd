extends Sprite2D

var max_speed : = 600.0
var velocity := Vector2(0, 0)
# For this practice, we moved the direction vector outside the _
# This allows the interactive practice to read its value and tes
# You can access and change the direction variable inside the _p
var direction := Vector2(0, 0)
func _process (delta: float) -> void:
# The direction is always equal to Vector2(0, 0)! Add code
	direction.x = Input. get_axis ("move_left", "move_right") 
	direction.y = Input.get_axis ("move_up","move_down")
#
	velocity = direction * max_speed
	position += velocity * delta 
	if velocity.length() > 0.0:
		rotation = velocity.angle ()
