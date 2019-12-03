extends PopupMenu
var gamePopUpMenu
export(String)var SAVE_PATH = "./savegame.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	gamePopUpMenu = get_node(".")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ResumeButton_pressed():
	gamePopUpMenu.hide()
	get_tree().paused = false
	pass # Replace with function body.


func _on_ExitButton_pressed():
	get_tree().paused = false
	get_tree().quit()
	pass # Replace with function body.


func _on_ResetButton_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_SaveButton_pressed():
	get_tree().paused = false
	var save_dict = {}
	var save_nodes = get_tree().get_nodes_in_group("Level")
	for i in save_nodes:
		save_dict[i.get_path()] = i.save()
	var save_game = File.new()
	save_game.open(SAVE_PATH, File.WRITE)
	
	save_game.store_line(to_json(save_dict))
	save_game.close()
	
	get_tree().quit()
	pass # Replace with function body.


func _on_MenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://title_scene/title_screen.tscn")
	pass # Replace with function body.


func _on_Button_pressed():
	gamePopUpMenu.show()
	get_tree().paused = true
	pass # Replace with function body.
	