extends Node2D
var gamePopUpMenu
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	gamePopUpMenu = get_node("GamePopupMenu")
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MenuButton_pressed():
	gamePopUpMenu.show()
	#pass # Replace with function body.
