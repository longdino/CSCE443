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



func _on_teleportBlock_body_entered(body):
	if body.get_name() == "Player":
		$FadeIn.show()
		$FadeIn.fade_in()
		#get_tree().change_scene("res://levels/level1.tscn")
		#body.position = body.get_reset_location()
	#pass # Replace with function body.


func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://levels/level1.tscn")
	pass # Replace with function body.
