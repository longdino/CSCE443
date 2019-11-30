extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var startPosition = Vector2(0,0)
var originalPosition = Vector2(0,0)
var playerPosition = Vector2(0,0)
var checkReached = false
var timeElapsed = 0
var funcAdjusted = false
	
const LOOP = preload("res://chain_popper/loop.tscn")
const LINK = preload("res://chain_popper/link.tscn")

export (float) var attackRadius = 1
export (float) var moveSpeed = 2

# Called when the node enters the scene tree for the first time.
func _ready():	
	var collisionShape = "CollisionShape2D"
	if (has_node(collisionShape)):
		var shape = get_node(collisionShape)
		shape.scale.x = attackRadius
		shape.scale.y = attackRadius
		
	var pathName = "KinematicBody2D"
	if (has_node(pathName)):
		var currentBlock = get_node(pathName)
		startPosition = currentBlock.global_position
		originalPosition = currentBlock.global_position
		playerPosition = currentBlock.global_position
		
		var parent = currentBlock
		for i in range (attackRadius * 20):
			var child = addLoop(parent)
			addLink(parent, child)
			parent = child
		addLink(parent, get_node("anchor"))
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pathName = "KinematicBody2D"
	if (has_node(pathName)):
		var currentBlock = get_node(pathName)
		originalPosition = currentBlock.global_position
		currentBlock.move_and_collide((playerPosition - originalPosition) * delta * moveSpeed)
		
		if (startPosition != originalPosition):
			timeElapsed = timeElapsed + delta
			if ((timeElapsed) > 2):
				adjustAngle(currentBlock, 0)
				currentBlock.move_and_collide((startPosition - (originalPosition + Vector2(0, 1))) * delta * moveSpeed)
				originalPosition = startPosition
				playerPosition = startPosition
				timeElapsed = 0
		
		#print(sqrt(pow(startPosition.x - originalPosition.x, 2) + pow(startPosition.y - originalPosition.y, 2)))
		
		if (sqrt(pow(startPosition.x - originalPosition.x, 2) + pow(startPosition.y - originalPosition.y, 2)) < 30):
			adjustAngle(currentBlock, 0)
		else:
			if ((playerPosition.x - originalPosition.x) != 0):
				if (!funcAdjusted):
					var angle = atan2(playerPosition.y - originalPosition.y, playerPosition.x - originalPosition.x)
					adjustAngle(currentBlock, angle + 180)

func adjustAngle(body, angle):
	body.rotation = angle
	funcAdjusted = !funcAdjusted
		
func addLoop(parent):
	var loop = LOOP.instance()
	loop.z_index = -1
	loop.position = get_node("anchor").position
	add_child(loop)
	return loop
	
func addLink(parent, child):
	var pin = LINK.instance()
	pin.node_a = parent.get_path()
	pin.node_b = child.get_path()
	parent.add_child(pin)

func _on_Popper_body_entered(body):
	#pass # Replace with function body.
	if body.get_name() == "Player":
		playerPosition = body.global_position
		checkReached = true
		