extends Control

export(String)var scene_path_to_load
export(String)var SAVE_PATH = "./savegame.json"
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
	scene_path_to_load = 'res://levels/hj/Hlevel1.tscn'#'res://sprites/Tiles/temp.tscn'
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


func _on_LoadButton_pressed():
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
	pass
