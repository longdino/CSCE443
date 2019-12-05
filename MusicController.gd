extends Control
onready var _player = $AudioStreamPlayer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func play(track_url: String):
	#track_url = "res://Audio/Antnio_Bizarro_-_11_-_The_Long_Way_Back.mp3"
	var track = load(track_url)
	_player.set_volume_db(-20.0)
	_player.stream = track
	_player.play()

func stop():
	_player.stop()
