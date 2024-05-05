extends Node2D

@onready var flame: Sprite2D = $Flame

func _ready() -> void:
	# This parameter of the shader material gives each flame a slightly different look and randomized animation.
	flame.material.set("shader_parameter/offset", global_position * 0.1)

@onready var target_node: Sprite2D = $SomeSprite2DNode

func toggle_target_node_visibility() -> void:
	if target_node.visible:
		target_node.visible = false
	else:
		target_node.visible = true
		
##or 
#both of these funcions works the same but this is a shortened way

#@onready var target_node: Sprite2D = $SomeSprite2DNode
#
#func toggle_target_node_visibility() -> void:
	#target_node.visible = not target_node.visible
	
	
