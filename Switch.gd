extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hiddenDoor = false
var startPosition = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Switch_body_entered(body):
	# print(global_position)
	
	# if the player enters the Area2D of the switch,
	# search the node tree for the Door corresponding to it
	# if exists, remove it from the scene
	if body.get_name() == "Player":
		var pathName = self.get_name()
		pathName = pathName.replace("Switch", "")
		pathName = "../Door" + pathName
		if (has_node(pathName)):
			var currentDoor = get_node(pathName)
			#currentDoor.queue_free()
			if(!hiddenDoor):
				startPosition = currentDoor.position
				currentDoor.position = Vector2(-100, -100)
				hiddenDoor = true
			else:
				currentDoor.position = startPosition
				hiddenDoor = false
