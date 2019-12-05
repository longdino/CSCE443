extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (float) var bulletSpeed = 2
export (float) var bulletDist = 7

# Called when the node enters the scene tree for the first time.
func _ready():
	var bulletNode = "Bullet/Area2D"
	if (has_node(bulletNode)):
		var node = get_node(bulletNode)
		node.bulletSpeed = bulletSpeed
		node.bulletDist = bulletDist

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Shooter_body_entered(body):
	if body.get_name() == "Player":
		# print(body.get_reset_location())
		body.position = body.get_reset_location()
