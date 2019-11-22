extends Control

var scene_path_to_load

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu/CenterRow/Buttons/NewGameButton.grab_focus()
	for button in $Menu/CenterRow/Buttons.get_children():
		if button.name == "ExitButton":
			button.connect("pressed", self, "quitGame")
		else:
			button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func quitGame():
	get_tree().quit()
	
func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)
