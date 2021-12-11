extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 40
const MAXFALLSPEED = 800
const MAXSPEED = 500
var JUMPFORCE = 1500
var ACCELERATION = 100

var time_start = 0
var time_now = 0

var motion = Vector2()
var facing_right = true
# Called when the node enters the scene tree for the first time.
func _ready():
	time_start = OS.get_unix_time()
	pass # Replace with function body.
	
func _physics_process(delta):
	time_now = OS.get_unix_time()
	var time_elapsed = time_now - time_start
	print(time_elapsed)
	
	motion.y += GRAVITY
	if motion.y >= MAXFALLSPEED:
		motion.y = MAXFALLSPEED
		
	if facing_right == true:
		$Sprite.scale.x = 10
	else:
		$Sprite.scale.x = -10
		
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	
	if Input.is_action_pressed("right") and time_elapsed < 100:
		motion.x += ACCELERATION
		facing_right = true
		$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("attack") and time_elapsed < 100:
		$AnimationPlayer.play("Attack")
	elif Input.is_action_pressed("left") and time_elapsed < 100:
		motion.x -= ACCELERATION
		facing_right = false
		$AnimationPlayer.play("Run")
	else:
		if time_elapsed < 100:
			motion.x = lerp(motion.x, 0, 0.2)
			$AnimationPlayer.play("Idle")
		
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMPFORCE
			
	if time_elapsed == 40:
		ACCELERATION = ACCELERATION - 0.5
		JUMPFORCE = JUMPFORCE - 2
	
	if time_elapsed == 60:
		ACCELERATION = ACCELERATION - 1
		JUMPFORCE = JUMPFORCE - 3
	
	if time_elapsed == 70:
		ACCELERATION = ACCELERATION - 0.1
		JUMPFORCE = JUMPFORCE - 1
		
	if time_elapsed == 80:
		ACCELERATION = ACCELERATION - 0.05
		
	if time_elapsed == 90:
		JUMPFORCE = JUMPFORCE - 1
	
	if time_elapsed == 100:
		ACCELERATION = 0
		JUMPFORCE = 0
		$AnimationPlayer.play("Death")
	elif time_elapsed > 100:
		$AnimationPlayer.play("DeathIdle")
	
	if !is_on_floor():
		if motion.y < 0:
			$AnimationPlayer.play("Jump")
		elif motion.y > 0:
			if Input.is_action_just_pressed("jump") and time_elapsed > 30 and time_elapsed < 40:
				motion.y = -JUMPFORCE
			else:
				$AnimationPlayer.play("Fall")
			
		
	motion = move_and_slide(motion, UP)


