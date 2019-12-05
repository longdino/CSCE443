extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timePassed = 0


const TP = preload("res://teleportBlock.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (has_node("Player")):
		var player = get_node("Player")
		var playerSprite = get_node("Player/Sprite")
	
		if (player.position.x < 500):
			player.position.x = (100*delta) + player.position.x
			playerSprite.play("run")
		else:
			player.position.x = 500
			playerSprite.play("death")
			timePassed = timePassed + delta
			if (timePassed > 10):
				var tp = TP.instance()
				tp.position = player.position
				tp.z_index = -3
				add_child(tp)

func rerouteScene():
	get_tree().change_scene("res://levels/credits.tscn")