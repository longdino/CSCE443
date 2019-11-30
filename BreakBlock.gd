extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (float) var resetTimer = 10
export (float) var disappearTimer = 1
var timeElapsed = 0
var startPosition = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	startPosition = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeElapsed += delta
	if (timeElapsed > resetTimer):
		var collision = get_node("RigidBody2D/CollisionShape2D")
		var sprite = get_node("RigidBody2D/Sprite")
		global_position = startPosition
		timeElapsed = 0
		collision.disabled = false
		sprite.play("idle")
		


func _on_BreakBlock_body_entered(body):
	if body.get_name() == "Player":
		var collision = get_node("RigidBody2D/CollisionShape2D")
		var sprite = get_node("RigidBody2D/Sprite")
		var t = Timer.new()
		t.set_wait_time(disappearTimer)
		#t.set_one_shot(true)
		self.add_child(t)
		t.start()
		sprite.play("crumble")
		yield(t, "timeout")
		collision.disabled = true
		t.set_wait_time(.5)
		t.start()
		sprite.play("fall")
		yield(t, "timeout")
		global_position = Vector2(-100, -100)
		t.queue_free()
