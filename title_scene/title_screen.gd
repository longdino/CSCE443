extends Control

var scene_path_to_load
export(String)var SAVE_PATH = "./savegame.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu/CenterRow/Buttons/NewGameButton.grab_focus()
	MusicController.play("res://Audio/Far_Out_There.ogg")
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


func _on_ContinueButton_pressed():
	var save_game = File.new()
	if not save_game.file_exists(SAVE_PATH):
		return

	save_game.open(SAVE_PATH, File.READ)
	var data = {}
	data = parse_json(save_game.get_as_text())
	print(data)
	for node_path in data.keys():
		print(data[node_path])
		for attribute in data[node_path]:
			if attribute == "path":
				print(data[node_path][attribute].replace('/root/', ''))
				var scene = data[node_path][attribute].replace('/root/', '') + '.tscn'
				get_tree().change_scene("res://levels/" + scene)

	save_game.close()
	pass # Replace with function body.
