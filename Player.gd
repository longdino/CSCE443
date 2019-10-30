extends KinematicBody2D

const SPEED = 200
const GRAVITY = 600
const JUMP_POWER = -300
const FLOOR = Vector2(0, -1)
const MAX_JUMPS = 2

var velocity = Vector2()
var jumps = MAX_JUMPS
var on_ground = false

func _apply_gravity(delta):
	velocity.y += GRAVITY * delta

func _apply_movement():
	if is_on_floor():
		on_ground = true
		jumps = MAX_JUMPS
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
