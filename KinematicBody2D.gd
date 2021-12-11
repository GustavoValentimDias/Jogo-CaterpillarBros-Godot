extends KinematicBody2D
var speed = 100
var a = 1
onready var obj = get_parent().get_node("Player")
var facing_right = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(delta):
	
	if facing_right == true:
		$Sprite.scale.x = 10
	else:
		$Sprite.scale.x = -10
		
	$AnimationPlayer.play("MageMove")
	var dir = (obj.global_position - global_position).normalized()
	
	if global_position[0] < -1100:
		facing_right = true
		a = 1
	elif global_position[0] > 700:
		facing_right = false
		a = -1
	
	move_and_collide(dir * 2 * a * speed * delta)
	
		
	print(global_position)
	
	pass # Replace with function body.

