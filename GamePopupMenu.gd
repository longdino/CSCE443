extends PopupMenu
var gamePopUpMenu
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	gamePopUpMenu = get_node(".")
	#gamePopUpMenu.set_custom_viewport(1)
	#pass # Replace with function body.

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
	pass # Replace with function body.


func _on_MenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://title_scene/title_screen.tscn")
	pass # Replace with function body.


func _on_Button_pressed():
	gamePopUpMenu.show()
	get_tree().paused = true
	pass # Replace with function body.
