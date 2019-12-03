extends Area2D
export(String)var scene_path_to_load
export(String)var present_scene_path
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	present_scene_path = get_tree().get_current_scene().get_name()
	#present_scene_path = get_tree().edited_scene_root.get_script().get_path()
	#print(present_scene_path)
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_teleportBlock_body_entered(body):
	if body.get_name() == "Player":
		$FadeIn.show()
		$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	var currLevel = present_scene_path.replace("l", "")
	currLevel = String(int(currLevel) + 1)
	print (currLevel)
	scene_path_to_load = "res://levels/l" + currLevel + ".tscn"
	print (scene_path_to_load)
	
	if (currLevel == "32"):
		scene_path_to_load = "res://title_scene/title_screen.tscn"
	
	get_tree().change_scene(scene_path_to_load)
