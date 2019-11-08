extends Control

export(String)var scene_path_to_load
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	get_tree().change_scene('res://title_scene/title_screen.tscn')
	
func _on_Level1Button_pressed():
	scene_path_to_load = 'res://sprites/Tiles/temp.tscn'
	$FadeIn.show()
	$FadeIn.fade_in()
	pass # Replace with function body.


func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)
	pass # Replace with function body.

# later when more game scene added
func _on_Level2Button_pressed():
	pass # Replace with function body.


func _on_Level3Button_pressed():
	pass # Replace with function body.


func _on_Level4Button_pressed():
	pass # Replace with function body.
