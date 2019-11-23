extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player
var bulletInitial = Vector2(0,0)
var bulletStart = global_position
var bulletEnd = Vector2(global_position.x - 100, global_position.y)

# Called when the node enters the scene tree for the first time.
func _ready():
	bulletInitial = global_position
	var pathName = "../../Player"
	if (has_node(pathName)):
		player = get_node(pathName) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var newPath = "../../Bullet"
	if (has_node(newPath)):
		var bulletBody = get_node(newPath)
		bulletBody.move_and_collide((bulletEnd - bulletStart) * delta * 2)
		if (bulletInitial.y - bulletBody.global_position.x > 0):
			resetBullet()
		
func _on_Bullet_body_entered(body):
	if body.get_name() == "Player":
		# print(body.get_reset_location())
		body.position = body.get_reset_location()
		resetBullet()
	else:
		resetBullet()
			
func resetBullet():
	var secondPath = "../../Bullet"
	if (has_node(secondPath)):
		get_node(secondPath).global_position = bulletInitial
