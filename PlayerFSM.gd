extends "res://StateMachine.gd"

onready var sprite = parent.get_node("Sprite")
# handles the player input
func _input(event):
	if [states.idle, states.run, states.fall, states.jump].has(state):
		if event.is_action_pressed("jump") && parent.jumps > 0:
			parent.jumps = parent.jumps - 1
			parent.velocity.y = parent.max_jump_velocity
			
	if [states.jump].has(state):
		if event.is_action_released("jump") && parent.velocity.y < parent.min_jump_velocity:
			parent.velocity.y = parent.min_jump_velocity
			
	if [states.wallslide].has(state):
		if event.is_action_pressed("jump"):
			set_state(states.jump)
			parent.wall_jump_beta()
			
	if [states.wallslide, states.idle, states.run, states.fall, states.jump].has(state):
		if event.is_action_pressed("dash"):
			set_state(states.dash)
			parent.dash_timer.start()
			parent.dash()
			
	if event.is_action("exit_game"):
		get_tree().quit()


# initialized the states of the player
# sets initial state to idle
func _ready():
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("wallslide")
	add_state("dash")
	call_deferred("set_state", states.idle)

func _state_logic(delta):
	parent._update_move_direction()
	parent._update_wall_direction()
	if state != states.wallslide:
		parent._handle_move_input()
	if state != states.dash:
		parent._apply_gravity(delta)
	if [states.wallslide].has(state):
		parent._cap_gravity_wallslide()
		parent._handle_wall_slide_sticking()
	if [states.dash].has(state):
		parent._handle_dash_movement()
		parent.velocity.y = 0
	parent.get_node("Wall Label").set_text(str(parent.facing))
	parent._apply_movement()
	if [states.run].has(state):
		sprite.set_speed_scale(abs(parent.velocity.x / parent.SPEED))
	
func _get_transition(delta):
	# this determines the transitions of the state machine
	# this is where all the logic for state transitions should happen
	match state:
		# conditions for transitions from idle state
		states.idle:
			if !parent._is_on_ground():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x > 0.01 || parent.velocity.x < -0.01:
				return states.run
		# conditions for transitions from run state
		states.run:
			if !parent._is_on_ground():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x < 0.01 && parent.velocity.x > -0.01:
				return states.idle
		states.jump:
			if parent.wall_direction != 0 && parent.wall_slide_cooldown.is_stopped():
				return states.wallslide
			elif parent._is_on_ground():
				return states.idle
			elif parent.velocity.y >= 0:
				return states.fall
		states.fall:
			if parent.wall_direction != 0 && parent.wall_slide_cooldown.is_stopped():
				return states.wallslide
			elif parent._is_on_ground():
				return states.idle
			elif parent.velocity.y < 0:
				return states.jump
		states.wallslide:
			if parent._is_on_ground():
				return states.idle
			elif parent.wall_direction == 0:
				return states.fall
		states.dash:
			if parent.dash_timer.is_stopped():
				if parent._is_on_ground():
					return states.idle
				elif parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y >= 0:
					return states.fall
				elif parent.wall_direction != 0:
					return states.wallslide
			elif parent.wall_direction != 0:
				return states.wallslide
				
	return null
	
func _enter_state(new_state, old_state):
	parent.get_node("State Label").set_text(states.keys()[new_state])
	match new_state:
		states.idle:
			sprite.play("idle")
			parent.jumps = parent.max_jumps
		states.run:
			sprite.play("run")

			parent.jumps = parent.max_jumps
		states.jump:
			sprite.play("jump")
		states.fall:
			pass
		states.wallslide:
			# parent.jumps = parent.max_jumps
			sprite.play("wallslide")
			
	
func _exit_state(old_state, new_state):
	match old_state:
		states.wallslide:
			#parent.wall_jump_timer.start()
			parent.wall_slide_cooldown.start()

func _on_WallSlideStickTimer_timeout():
	if [states.wallslide].has(state):
		set_state(states.fall)


func _on_GhostTimer_timeout():
	if [states.dash].has(state):
		var this_ghost = preload("res://ghost.tscn").instance()
		# adds the ghost to the actual scene rather than the player
		get_parent().get_parent().add_child(this_ghost)
		this_ghost.position = parent.position
		this_ghost.texture = parent.sprite.frames.get_frame(parent.sprite.animation, parent.sprite.frame)
		if parent.facing == 1:
			this_ghost.flip_h = false
		else:
			this_ghost.flip_h = true
