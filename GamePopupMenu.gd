extends PopupMenu
var gamePopUpMenu
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	gamePopUpMenu = get_node(".")
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ResumeButton_pressed():
	gamePopUpMenu.hide()
	pass # Replace with function body.


func _on_GameMenuButton_pressed():
	get_tree().change_scene("res://title_scene/title_screen.tscn")
	pass # Replace with function body.


func _on_ExitButton_pressed():
	get_tree().quit()
	pass # Replace with function body.
