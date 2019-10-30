extends KinematicBody2D

const SPEED = 16 * 10
const JUMP_MAX = -300
const JUMP_MIN = -100
const FLOOR = Vector2(0, -1)

var max_jump_height = 16 * 4.25
var min_jump_height = 16 * 0.8
var max_jump_velocity
var min_jump_velocity
var jump_duration = 0.5
var gravity
var max_jumps = 2

var velocity = Vector2()
var jumps = max_jumps
var on_ground = false

func _ready():
	gravity = 2 * max_jump_height / pow(jump_duration, 2)
	max_jump_velocity = -sqrt(2 * gravity * max_jump_height) 
	min_jump_velocity = -sqrt(2 * gravity * min_jump_height)

func _apply_gravity(delta):
	velocity.y += gravity * delta

func _apply_movement():
	if is_on_floor():
		on_ground = true
		jumps = max_jumps
	else:
		on_ground = false

	velocity = move_and_slide(velocity, FLOOR)

func _handle_move_input():
	var move_direction = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	velocity.x = lerp(velocity.x, SPEED * move_direction, 0.2)
	if move_direction != 0:
		$Sprite.scale.x = move_direction

func _is_on_ground():
	return on_ground
