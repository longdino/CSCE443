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


func _on_Hazard_body_entered(body):
	# if the player enters the Area2D of the hazard, reset the player to private variable location
	if body.get_name() == "Player":
		# print(body.get_reset_location())
		body.position = body.get_reset_location()
