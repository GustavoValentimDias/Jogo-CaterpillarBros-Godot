extends RigidBody2D

var speed = 100
onready var obj = get_parent().get_node("Player")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	$AnimationPlayer.play("snakemove")
	var dir = (obj.global_position - global_position).normalized()
	move
	#move_and_collide(dir * speed * delta)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
