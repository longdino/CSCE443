extends Control

var scene_path_to_load

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu/CenterRow/Buttons/NewGameButton.grab_focus()
	for button in $Menu/CenterRow/Buttons.get_children():
		if button.name == "ExitButton":
			button.connect("pressed", self, "quit")
		else:
			button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func quit():
	get_tree().quit()
	
func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)
