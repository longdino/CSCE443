extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var startPosition = Vector2(0,0)
var originalPosition = Vector2(0,0)
var playerPosition = Vector2(0,0)
var checkReached = false
var moveSpeed = 2
var timeElapsed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var pathName = "KinematicBody2D"
	if (has_node(pathName)):
		var currentBlock = get_node(pathName)
		startPosition = currentBlock.global_position
		originalPosition = currentBlock.global_position
		playerPosition = currentBlock.global_position
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pathName = "KinematicBody2D"
	if (has_node(pathName)):
		var currentBlock = get_node(pathName)
		originalPosition = currentBlock.global_position
		currentBlock.move_and_collide((playerPosition - originalPosition)* delta * moveSpeed)
		
		if (startPosition != originalPosition):
			timeElapsed = timeElapsed + delta
			if ((timeElapsed) > 3):
				currentBlock.move_and_collide((startPosition - originalPosition)* delta * moveSpeed)
				originalPosition = startPosition
				playerPosition = startPosition
				timeElapsed = 0
#	pass


func _on_Popper_body_entered(body):
	#pass # Replace with function body.
	if body.get_name() == "Player":
		playerPosition = body.global_position
		checkReached = true
		