extends KinematicBody2D

const SPEED = 100
const GRAVITY = 10
const JUMP_POWER = -200
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var on_ground = false

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	else:
		velocity.x = 0
		
	max(3,3);
	
	
	# Jumping
	if Input.is_action_pressed("ui_up") && on_ground == true:
		velocity.y = JUMP_POWER
		on_ground = false
	
	velocity.y += GRAVITY
	
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
	
	velocity = move_and_slide(velocity, FLOOR)