extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var resetTimer = 10
var timeElapsed = 0
var startPosition = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	startPosition = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeElapsed += delta
	if (timeElapsed > resetTimer):
		global_position = startPosition
		timeElapsed = 0


func _on_BreakBlock_body_entered(body):
	if body.get_name() == "Player":
		var t = Timer.new()
		t.set_wait_time(1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		global_position = Vector2(-100, -100)
		t.queue_free()
