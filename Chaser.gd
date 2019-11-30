extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var startPosition = Vector2(0,0)
var originalPosition = Vector2(0,0)
var playerPosition = Vector2(0,0)
var inArea = false
var timeElapsed = 0
var speedIncrease = 1
export (float) var moveSpeed = 1
export (float) var xScale = 1
export (float) var yScale = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var pathName = "KinematicBody2D"
	if (has_node(pathName)):
		var currentBlock = get_node(pathName)
		startPosition = currentBlock.global_position
		originalPosition = currentBlock.global_position
		playerPosition = currentBlock.global_position
		
	var collisionShape = "CollisionShape2D"
	if (has_node(collisionShape)):
		var shape = get_node(collisionShape)
		shape.scale.x = xScale
		shape.scale.y = yScale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (inArea):
		var playerPath = "../Player"
		if (has_node(playerPath)):
			var playerBlock = get_node(playerPath)
			playerPosition = playerBlock.global_position
		
		var pathName = "KinematicBody2D"
		if (has_node(pathName)):
			var currentBlock = get_node(pathName)
			originalPosition = currentBlock.global_position
			speedIncrease += 0.05
			currentBlock.move_and_collide((playerPosition - originalPosition) * delta * moveSpeed * speedIncrease)
			
	else:
		# resetting hazard
		speedIncrease = 1
		var pathName = "KinematicBody2D"
		if (has_node(pathName)):
			var currentBlock = get_node(pathName)
			originalPosition = currentBlock.global_position
			currentBlock.move_and_collide((startPosition - originalPosition) * delta * moveSpeed / 2)



func _on_Chaser_body_entered(body):
	if body.get_name() == "Player":
		inArea = true


func _on_Chaser_body_exited(body):
	if body.get_name() == "Player":
		inArea = false
