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
	print(present_scene_path)
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_teleportBlock_body_entered(body):
	if body.get_name() == "Player":
		$FadeIn.show()
		$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	if present_scene_path == "temp":
		scene_path_to_load = "res://levels/level1.tscn"
	elif present_scene_path == "level1":
		scene_path_to_load = "res://levels/level1.tscn"
	elif present_scene_path == "ag1":
		scene_path_to_load = "res://levels/ag/ag2.tscn"
	elif present_scene_path == "ag2":
		scene_path_to_load = "res://levels/ag/ag3.tscn"
	elif present_scene_path == "ag3":
		scene_path_to_load = "res://levels/ag/ag4.tscn"
	elif present_scene_path == "ag4":
		scene_path_to_load = "res://levels/ag/ag5.tscn"
	elif present_scene_path == "ag5":
		scene_path_to_load = "res://levels/ag/ag1.tscn"
	elif present_scene_path == "Hlevel1":
		scene_path_to_load = "res://levels/hj/Hlevel2.tscn"
	elif present_scene_path == "Hlevel2":
		scene_path_to_load = "res://levels/hj/Hlevel3.tscn"
	elif present_scene_path == "Hlevel3":
		scene_path_to_load = "res://levels/hj/Hlevel4.tscn"
	elif present_scene_path == "Hlevel4":
		scene_path_to_load = "res://levels/hj/Hlevel5.tscn"
	elif present_scene_path == "Hlevel5":
		scene_path_to_load = "res://levels/hj/Hlevel1.tscn"
	elif present_scene_path == "tut1":
		scene_path_to_load = "res://levels/tutorial/tut2.tscn" 
	else:
		scene_path_to_load = "res://levels/tut/tut1.tscn"
		
	get_tree().change_scene(scene_path_to_load)
