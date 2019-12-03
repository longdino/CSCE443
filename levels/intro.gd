extends RichTextLabel

var lapsed = 0
var charNum = 0
var playerExists = false

const PLAYER = preload("res://Player.tscn")

func _ready():
	lapsed = 0
	set_visible_characters(0)
	get_node("../introsprite").playing = true

func _process(delta):
	if(lapsed < 7):
		lapsed = lapsed + delta
	else:
		lapsed = lapsed + delta + delta
	charNum = set_visible_characters(lapsed)
	
	if(lapsed > 19.5):
		set_visible_characters(0)
		get_node("../introsprite").visible = false
		if(!playerExists):
			var player = PLAYER.instance()
			player.position = Vector2(50, 260)
			get_node("../../intro").add_child(player)
			playerExists = true