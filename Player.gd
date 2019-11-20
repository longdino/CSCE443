extends KinematicBody2D

const SPEED = 16 * 13
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


var max_wall_jump_height_y = 16 * 3
var min_wall_jump_height_y = 16 * 1
var wall_jump_velocity_x
var max_wall_jump_velocity_y
var min_wall_jump_velocity_y
var wall_jump_duration = 1.0
var wall_jump_gravity
var max_wallslide_velocity = 16 * 2
var wall_jump_distance_x = 16 * 3

var dash_distance = 16 * 7
var dash_duration = .25
var dash_velocity

var ground_acceleration
var ground_deacceleration
var air_acceleration
var air_deacceleration
var ground_acceleration_time = 0.2
var air_acceleration_time = 0.1
var ground_deacceleration_time = 0.1
var air_deacceleration_time = 0.05
var ground_deacceleration_weight = 0.4

var facing = 1

# Cached nodes
onready var left_wall_raycasts = $WallRaycasts/LeftWallRaycasts
onready var right_wall_raycasts = $WallRaycasts/RightWallRaycasts
onready var floor_raycasts = $FloorRaycasts
onready var wall_slide_cooldown = $WallSlideCooldown
onready var wall_slide_sticky_timer = $WallSlideStickTimer
onready var dash_timer = $DashTimer
onready var sprite = $Sprite
onready var wall_jump_timer = $WallJumpTimer

var velocity = Vector2()
var jumps
var on_ground = false
var resetPoint = Vector2(0,0)
var wall_direction = 0
var move_direction = 0

func _ready():
	jumps = max_jumps

	gravity = 2 * max_jump_height / pow(jump_duration, 2)
	max_jump_velocity = -sqrt(2 * gravity * max_jump_height)
	min_jump_velocity = -sqrt(2 * gravity * min_jump_height)

	wall_jump_timer.set_wait_time(wall_jump_duration);
	
	wall_jump_gravity = 2 * max_wall_jump_height_y / pow(wall_jump_duration, 2)
	max_wall_jump_velocity_y = -sqrt(2 * wall_jump_gravity * max_wall_jump_height_y)
	min_wall_jump_velocity_y = -sqrt(2 * wall_jump_gravity * min_wall_jump_height_y)
	
	wall_jump_velocity_x = wall_jump_distance_x / wall_jump_duration
	

	ground_acceleration = SPEED / ground_acceleration_time
	air_acceleration = SPEED / air_acceleration_time

	ground_deacceleration = SPEED / ground_deacceleration_time
	air_deacceleration = SPEED / air_deacceleration_time

	dash_timer.set_wait_time(dash_duration)

func _is_on_ground():
	for raycast in floor_raycasts.get_children():
		if raycast.is_colliding():
			on_ground = true
			return on_ground
	on_ground = false
	return on_ground

func _apply_gravity(delta):
	if wall_jump_timer.is_stopped():
		velocity.y += gravity * delta
	else:
		velocity.y += wall_jump_gravity * delta

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
	wall_jump_velocity.x = wall_jump_velocity_x
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
			return 0.8
		elif move_direction == sign(velocity.x) && abs(velocity.x) > SPEED:
			return 0.8
		else:
			return 0.8

func _apply_movement():
	velocity = move_and_slide(velocity, FLOOR)

func set_reset_location(newPosition):
	resetPoint = newPosition

func get_reset_location():
	return resetPoint

# updates the the wall direction bases on the raycasts
func _update_wall_direction():
	var is_near_wall_left = _check_is_valid_wall(left_wall_raycasts)
	var is_near_wall_right = _check_is_valid_wall(right_wall_raycasts)

	if is_near_wall_left && is_near_wall_right:
		wall_direction = move_direction
	else:
		wall_direction = -int(is_near_wall_left) + int(is_near_wall_right)
		if wall_direction != 0 && !_is_on_ground():
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

func _handle_move_input(delta):
	#velocity.x = lerp(velocity.x, SPEED * move_direction, _get_h_weight())
	var new_velocity
	# deal with acceleration and deacceleration
	if move_direction != 0:
		if _is_on_ground():
			new_velocity = velocity.x + (ground_acceleration * delta * move_direction)
		else:
			new_velocity = velocity.x + (air_acceleration * delta * move_direction)
		new_velocity = min(SPEED, abs(new_velocity)) * move_direction
	else:
		if _is_on_ground():
			#new_velocity  = lerp(velocity.x, 0.0, ground_deacceleration_weight)
			if velocity.x < 0.1 && velocity.x > -0.1:
				new_velocity = 0.0
			elif velocity.x > 0:
				new_velocity = velocity.x - (ground_deacceleration * delta)
				if new_velocity < 0.0:
					new_velocity = 0.0
			elif velocity.x < 0:
				new_velocity = velocity.x + (ground_deacceleration * delta)
				if new_velocity > 0.0:
					new_velocity = 0.0
		else:
			#new_velocity  = lerp(velocity.x, 0.0, ground_deacceleration_weight)
			if velocity.x < 0.1 && velocity.x > -0.1:
				new_velocity = 0.0
			elif velocity.x > 0:
				new_velocity = velocity.x - (ground_deacceleration * delta)
				if new_velocity < 0.0:
					new_velocity = 0.0
			elif velocity.x < 0:
				new_velocity = velocity.x + (ground_deacceleration * delta)
				if new_velocity > 0.0:
					new_velocity = 0.0

	#velocity.x = lerp(velocity.x, new_velocity, _get_h_weight())
	velocity.x = new_velocity
	if move_direction != 0:
		$Sprite.scale.x = facing
