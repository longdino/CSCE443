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


func _on_BreakBlock_body_entered(body):
	if body.get_name() == "Player":
		var pathName = "RigidBody2D"
		if (has_node(pathName)):
			var currentBlock = get_node(pathName)
			currentBlock.queue_free()
