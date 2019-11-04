extends KinematicBody2D

const SPEED = 16 * 10
const JUMP_MAX = -300
const JUMP_MIN = -100
const FLOOR = Vector2(0, -1)
const WALL_JUMP_VELOCITY = Vector2(1000, -100)

var max_jump_height = 16 * 4.25
var min_jump_height = 16 * 0.8
var max_jump_velocity
var min_jump_velocity
var jump_duration = 0.5
var gravity
var max_jumps = 2

var max_wall_jump_height_x = 16 * 7
var max_wall_jump_height_y = 16 * 3
var min_wall_jump_height_x = 16 * 1
var min_wall_jump_height_y = 16 * 1
var max_wall_jump_velocity_x
var max_wall_jump_velocity_y
var min_wall_jump_velocity_x
var min_wall_jump_velocity_y
var wall_jump_duration = 1.0
var wall_jump_gravity_x
var wall_jump_gravity_y
var max_wallslide_velocity = 16 * 2

var dash_distance = 16 * 7
var dash_duration = .25
var dash_velocity

var facing = 1

# Cached nodes
onready var left_wall_raycasts = $WallRaycasts/LeftWallRaycasts
onready var right_wall_raycasts = $WallRaycasts/RightWallRaycasts
onready var floor_raycasts = $FloorRaycasts
onready var wall_slide_cooldown = $WallSlideCooldown
onready var wall_slide_sticky_timer = $WallSlideStickTimer
onready var dash_timer = $DashTimer
onready var sprite = $Sprite

var velocity = Vector2()
var jumps
var on_ground = false
var resetPoint = Vector2(0 , 0)
var wall_direction = 0
var move_direction = 0

func _ready():
	jumps = max_jumps
	
	gravity = 2 * max_jump_height / pow(jump_duration, 2)
	max_jump_velocity = -sqrt(2 * gravity * max_jump_height) 
	min_jump_velocity = -sqrt(2 * gravity * min_jump_height)
	
	wall_jump_gravity_x = 2 * max_wall_jump_height_x / pow(wall_jump_duration, 2) 
	max_wall_jump_velocity_x = -sqrt(2 * wall_jump_gravity_x * max_wall_jump_height_x) 
	min_wall_jump_velocity_x = -sqrt(2 * wall_jump_gravity_x * min_wall_jump_height_x) 
	
	dash_timer.set_wait_time(dash_duration)
	

func _is_on_ground():
	for raycast in floor_raycasts.get_children():
		if raycast.is_colliding():
			on_ground = true
			return on_ground
	on_ground = false
	return on_ground
	
func _apply_gravity(delta):
	velocity.y += gravity * delta
	
func wall_jump():
	var wall_jump_velocity = WALL_JUMP_VELOCITY
	wall_jump_velocity.x *= -wall_direction
	velocity = wall_jump_velocity
	
func _handle_dash_movement():
	if !dash_timer.is_stopped():
		velocity.x = dash_velocity
	
func dash():
	# v = d/t
	dash_velocity = (dash_distance / dash_duration) * facing
	

func wall_jump_beta():
	var wall_jump_velocity = Vector2()
	wall_jump_velocity.x = max_wall_jump_velocity_x
	wall_jump_velocity.y = max_jump_velocity
	wall_jump_velocity.x *= wall_direction
	velocity = wall_jump_velocity
	$Sprite.scale.x = -wall_direction
	facing = -wall_direction
	

func _cap_gravity_wallslide():
	velocity.y = min(velocity.y, max_wallslide_velocity)

func _handle_wall_slide_sticking():
	if move_direction != 0 && move_direction != wall_direction:
		if wall_slide_sticky_timer.is_stopped():
			wall_slide_sticky_timer.start()
	else:
		wall_slide_sticky_timer.stop()

func _get_h_weight():
	if _is_on_ground():
		return 0.4
	else:
		if move_direction == 0 && wall_direction != 0:
			return 0.0
		elif move_direction == sign(velocity.x) && abs(velocity.x) > SPEED:
			return 0.0
		else:
			return 0.8
			
func _apply_movement():
	velocity = move_and_slide(velocity, FLOOR)
	
func set_reset_location(newPosition):
	resetPoint = newPosition
	print(resetPoint)
	
func get_reset_location():
	return resetPoint
	print(resetPoint)
	

# updates the the wall direction bases on the raycasts
func _update_wall_direction():
	var is_near_wall_left = _check_is_valid_wall(left_wall_raycasts)
	var is_near_wall_right = _check_is_valid_wall(right_wall_raycasts)
	
	if is_near_wall_left && is_near_wall_right:
		wall_direction = move_direction
	else:
		wall_direction = -int(is_near_wall_left) + int(is_near_wall_right)
		if wall_direction != 0:
			facing = -wall_direction


# checks raycasts to see if we are close to a wall
func _check_is_valid_wall(wall_raycasts):
	for raycast in wall_raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

func _update_move_direction():
	move_direction = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	if Input.is_action_pressed("move_left"):
		facing = -1
	elif Input.is_action_pressed("move_right"):
		facing = 1

func _handle_move_input():
	velocity.x = lerp(velocity.x, SPEED * move_direction, _get_h_weight())
	if move_direction != 0:
		$Sprite.scale.x = move_direction

func _is_on_ground():
	return on_ground
	
func _ready():
	resetPoint = global_position

