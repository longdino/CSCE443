extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timeElapsed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeElapsed = timeElapsed + delta
	
	if (timeElapsed > 3):
		if (has_node("Label")):
			var textScroll = get_node("Label")
			
			if(textScroll.rect_position.y > -1200):
				textScroll.rect_position.y = textScroll.rect_position.y - (delta*80)
			else:
				get_tree().change_scene("res://title_scene/title_screen.tscn")

