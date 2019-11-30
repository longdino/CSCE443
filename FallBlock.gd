extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = false
var startPosition = Vector2(0, 0)
var charPosition = Vector2(0, 0)
var fallRate = 1
var timeElapsed = 0
export (float) var resetTimer = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	startPosition = global_position
	charPosition = global_position # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# if not interacted with, stay still, else begin falling
	if(!active):
		global_position = charPosition
	else:
		global_position.y = global_position.y + fallRate
		timeElapsed += delta
		
	if (timeElapsed > resetTimer):
		global_position = startPosition
		charPosition = startPosition
		active = false
		timeElapsed = 0


func _on_FallBlock_body_entered(body):
	# if the player interacts with area, start movement
	if body.get_name() == "Player":
		active = true;

