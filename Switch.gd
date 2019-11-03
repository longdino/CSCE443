extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
			currentDoor.queue_free()
