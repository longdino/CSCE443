extends "res://StateMachine.gd"


# handles the player input
func _input(event):
	if [states.idle, states.run, states.fall, states.jump].has(state):
		if event.is_action_pressed("jump") && parent.jumps > 0:
			parent.jumps -= 1
			parent.velocity.y = parent.JUMP_POWER

# initialized the states of the player
# sets initial state to idle
func _ready():
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	call_deferred("set_state", states.idle)

func _state_logic(delta):
	parent._handle_move_input()
	parent._apply_gravity(delta)
	parent._apply_movement()
	
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
			if parent._is_on_ground():
				return states.idle
			elif parent.velocity.y >= 0:
				return states.fall
		states.fall:
			if parent._is_on_ground():
				return states.idle
			elif parent.velocity.y < 0:
				return states.jump
				
	return null
	
func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent.get_node("State Label").set_text("idle")
		states.run:
			parent.get_node("State Label").set_text("run")
		states.jump:
			parent.get_node("State Label").set_text("jump")
		states.fall:
			parent.get_node("State Label").set_text("fall")
	
func _exit_state(old_state, new_state):
	pass