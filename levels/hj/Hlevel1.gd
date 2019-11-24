extends Node2D
var gamePopUpMenu
onready var menu = $GamePopupMenu/PopupMenu
onready var anim_player = get_node("AnimationPlayer")
onready var player = $Player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	#player.
	
	gamePopUpMenu = get_node("GamePopupMenu")
	#anim_player.connect("animation_finished", self, "on_finished")
	get_tree().get_root().set_disable_input(true)
	anim_player.play("dialogue")
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_finished():
	$AnimationPlayer/RichTextLabel.hide()

func _on_MenuButton_pressed():
	#gamePopUpMenu.show()
	menu.show()
	
	#pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer/RichTextLabel.hide()
	print("animation finished")
	get_tree().get_root().set_disable_input(false)
	#pass # Replace with function body.
