extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (bool) var hiddenDoor = false
var startPosition = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	var pathName = self.get_name()
	pathName = pathName.replace("Switch", "")
	pathName = "../Door" + pathName
	if (has_node(pathName)):
		var currentDoor = get_node(pathName)
		startPosition = currentDoor.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func toggleSwitch(normalReset):
	var pathName = self.get_name()
	pathName = pathName.replace("Switch", "")
	pathName = "../Door" + pathName
	if (has_node(pathName)):
		var currentDoor = get_node(pathName)
		#currentDoor.queue_free()
		if(normalReset == true):
			if(!hiddenDoor):
				startPosition = currentDoor.position
				if(currentDoor.get_class() == "AnimatedSprite"): #here incase the door is an old without updated sprites
					currentDoor.play("crumble")
					yield(get_tree().create_timer(1.5), "timeout")
				currentDoor.position = Vector2(-100, -100)
				hiddenDoor = true
				
			else:
				currentDoor.position = startPosition
				hiddenDoor = false
				if(currentDoor.get_class() == "AnimatedSprite"): #here incase the door is an old without updated sprites
					currentDoor.play("idle")
		else:
			currentDoor.position = startPosition
			hiddenDoor = false

func _on_Switch_body_entered(body):
	# print(global_position)
	
	# if the player enters the Area2D of the switch,
	# search the node tree for the Door corresponding to it
	# if exists, remove it from the scene
	if body.get_name() == "Player":
		toggleSwitch(true)
